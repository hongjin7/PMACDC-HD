using PowerModelsACDC
using Ipopt
using JuMP
using PowerModels
using DataFrames
using XLSX

model = Model(Ipopt.Optimizer)
#register(model, :sign, 1, sign; autodiff = true)

#result = run_acdcopf("test/data/case5_acdc.m", ACPPowerModel, Ipopt.Optimizer)
#result = run_acdcopf("test/data/case32_g16out.m", ACPPowerModel, Ipopt.Optimizer);
#result = run_acdcopf("test/data/case32_2conv4outage.m", ACPPowerModel, Ipopt.Optimizer);
#result = run_acdcopf("test/data/case32_1.m", ACPPowerModel, Ipopt.Optimizer)
#result = run_acdcopf("test/data/case32_2cutbr.m", ACPPowerModel, Ipopt.Optimizer);
result = run_acdcopf("test/data/case32_2.m", ACPPowerModel, Ipopt.Optimizer);
#result = run_acdcopf("test/data/case32_2dconv.m", ACPPowerModel, Ipopt.Optimizer);
# Load the data
gen_data = result["solution"]["gen"]
bus_data = result["solution"]["bus"]
conv_data = result["solution"]["convdc"]
busdc_data = result["solution"]["busdc"]

# Create DataFrames
gen_df = DataFrame(gen_id = collect(keys(gen_data)), pg = [x["pg"] for x in values(gen_data)], qg = [x["qg"] for x in values(gen_data)])
bus_df = DataFrame(bus_id = collect(keys(bus_data)), va = [x["va"] for x in values(bus_data)], vm = [x["vm"] for x in values(bus_data)])
conv_df = DataFrame(conv_id = collect(keys(conv_data)), pconv = [x["pconv"] for x in values(conv_data)])
#conv_df = DataFrame(conv_id = collect(keys(conv_data)), droop = [x["droop"] for x in values(conv_data)], pconv = [x["pconv"] for x in values(conv_data)])
#conv_df =  DataFrame(conv_id = collect(keys(conv_data)), droop = [x["droop"] for x in values(conv_data)], pconv = [x["pconv"] for x in values(conv_data)], kfdr =  [x["k_fdroop"] for x in values(conv_data)])
busdc_df = DataFrame(bus_id = collect(keys(busdc_data)), vdc = [x["vm"] for x in values(busdc_data)])

# Create a new Excel workbook
XLSX.openxlsx("output.xlsx", mode="w") do xf
    sheet_gen = XLSX.addsheet!(xf, "Gen")
    XLSX.writetable!(sheet_gen, gen_df)
    sheet_bus = XLSX.addsheet!(xf, "Bus")
    XLSX.writetable!(sheet_bus, bus_df)
    sheet_conv = XLSX.addsheet!(xf, "Conv")
    XLSX.writetable!(sheet_conv, conv_df)
    sheet_busdc = XLSX.addsheet!(xf, "BusDC")
    XLSX.writetable!(sheet_busdc, busdc_df)
end



##############################################################
#println(keys(result["solution"]["convdc"]["1"]["droop"]))
#println(result["solution"]["gen"])
#println(keys(result["solution"]))
#=
##output data

##gen_data output
gen_data = result["solution"]["gen"];
df = DataFrame(gen_id = collect(keys(gen_data)), pg = [x["pg"] for x in values(gen_data)], qg = [x["qg"] for x in values(gen_data)])
XLSX.writetable("gen.xlsx", collect(DataFrames.eachcol(df)), DataFrames.names(df))#

##bus_data output
bus_data = result["solution"]["bus"];
bf = DataFrame(Bus_ID = collect(keys(bus_data)), VA = [x["va"] for x in values(bus_data)], VM = [x["vm"] for x in values(bus_data)])
XLSX.writetable("bus.xlsx", collect(DataFrames.eachcol(bf)), DataFrames.names(bf))

##conv output
conv_data = result["solution"]["convdc"];
#cf = DataFrame(conv_ID = collect(keys(conv_data)), droop = [x["droop"] for x in values(conv_data)], pdc = [x["pdc"] for x in values(conv_data)])
cf = DataFrame(conv_ID = collect(keys(conv_data)), pconv = [x["pconv"] for x in values(conv_data)])
XLSX.writetable("conv.xlsx", collect(DataFrames.eachcol(cf)), DataFrames.names(cf))

##busdc_data output
busdc_data = result["solution"]["busdc"];
bdcf = DataFrame(Bus_ID = collect(keys(busdc_data)), VM = [x["vm"] for x in values(busdc_data)])
XLSX.writetable("busdc.xlsx", collect(DataFrames.eachcol(bdcf)), DataFrames.names(bdcf))
=#