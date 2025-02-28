export run_acdcopf

""
function run_acdcopf(file::String, model_type::Type, solver; kwargs...)
    data = _PM.parse_file(file)
    PowerModelsACDC.process_additional_data!(data)
    return run_acdcopf(data, model_type, solver; ref_extensions = [add_ref_dcgrid!], kwargs...)
end

""
function run_acdcopf(data::Dict{String,Any}, model_type::Type, solver; kwargs...)
    return _PM.solve_model(data, model_type, solver, build_acdcopf; ref_extensions = [add_ref_dcgrid!], kwargs...)
end

""
function build_acdcopf(pm::_PM.AbstractPowerModel)
    _PM.variable_bus_voltage(pm)
    _PM.variable_gen_power(pm)
    _PM.variable_branch_power(pm)

    variable_active_dcbranch_flow(pm)
    variable_dcbranch_current(pm)
    variable_dc_converter(pm)
    variable_dcgrid_voltage_magnitude(pm)

    # _PM.objective_min_fuel_cost(pm)
    
    #minimize voltage deviation
    nw = _PM.nw_id_default
    JuMP.@objective(pm.model, Min, sum(((vdcm[i]- 1)^2) for i in _PM.ids(pm, nw, :busdc)))

    _PM.constraint_model_voltage(pm)
    constraint_voltage_dc(pm)

    for i in _PM.ids(pm, :ref_buses)
        _PM.constraint_theta_ref(pm, i)
    end

    for i in _PM.ids(pm, :bus)
        constraint_power_balance_ac(pm, i)
    end

    for i in _PM.ids(pm, :branch)
        _PM.constraint_ohms_yt_from(pm, i)
        _PM.constraint_ohms_yt_to(pm, i)
        _PM.constraint_voltage_angle_difference(pm, i) #angle difference across transformer and reactor - useful for LPAC if available?
        _PM.constraint_thermal_limit_from(pm, i)
        _PM.constraint_thermal_limit_to(pm, i)
    end
    for i in _PM.ids(pm, :busdc)
        constraint_power_balance_dc(pm, i)
    end
    for i in _PM.ids(pm, :branchdc)
        constraint_ohms_dc_branch(pm, i)
    end

 ###base case
 #for i in _PM.ids(pm, :convdc)
 #    constraint_converter_losses(pm, i)
 #    constraint_converter_current(pm, i)
 #    constraint_conv_transformer(pm, i)
 #    constraint_conv_reactor(pm, i)
 #    constraint_conv_filter(pm, i)
 #    if pm.ref[:it][:pm][:nw][_PM.nw_id_default][:convdc][i]["islcc"] == 1
 #        constraint_conv_firing_angle(pm, i)
 #    end
 #end

    ##droop control
    for (c, conv) in _PM.ref(pm, :convdc)
        constraint_conv_transformer(pm, c)
        constraint_conv_reactor(pm, c)
        constraint_conv_filter(pm, c)
        if conv["type_dc"] == 2
            constraint_dc_voltage_magnitude_setpoint(pm, c)
            constraint_reactive_conv_setpoint(pm, c)
        elseif conv["type_dc"] == 3
            if typeof(pm) <: _PM.AbstractACPModel || typeof(pm) <: _PM.AbstractACRModel
                constraint_dc_droop_control(pm, c)
                constraint_reactive_conv_setpoint(pm, c)
            else
                Memento.warn(_PM._LOGGER, join(["Droop only defined for ACP and ACR formulations, converter ", c, " will be treated as type 2"]))
                constraint_dc_voltage_magnitude_setpoint(pm, c)
                constraint_reactive_conv_setpoint(pm, c)
            end
        else
            if conv["type_ac"] == 2
                constraint_active_conv_setpoint(pm, c)
            else
                constraint_active_conv_setpoint(pm, c)
                constraint_reactive_conv_setpoint(pm, c)
            end
        end
        constraint_converter_losses(pm, c)
        constraint_converter_current(pm, c) 
    end
end