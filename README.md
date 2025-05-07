# PMACDC-HD.jl

**PMACDC-HD.jl** (PowerModelsACDC for Hybrid Droop Control)  

This repository contains the optimization models and case studies in the paper 'Optimal Droop Control Strategy for Coordinated Voltage Regulation and Power Sharing in Hybrid AC-MTDC Systems' written by Hongjin Du under the supervision of Pedro P. Vergara, Peter Palensky, Aleksandra Lekić.

## Overview

**PMACDC-HD.jl** provides an enhanced Optimal Power Flow (OPF) framework for hybrid AC-MTDC systems, integrating a novel droop control strategy that jointly optimizes DC voltage regulation and AC frequency support.  
The optimization process is built upon a **forked and extended version** of [PowerModelsACDC.jl](https://github.com/lanl-ansi/PowerModelsACDC.jl), enabling comparative studies among multiple control strategies under unified modeling.

## Repository Structure

To facilitate systematic comparison, three dedicated branches are created:

- **active-power-control**  
  Fixed active power references without droop-based regulation.
  
- **adaptive-droop-control**  
  Droop coefficients adjusted adaptively to enhance DC voltage control.

- **vf-droop-control**  
  Combined voltage-frequency droop control in selected converters.

Each branch independently solves the corresponding OPF problem and provides steady-state operating points for hybrid AC-MTDC systems.

## Key Features

- Forked and customized **PowerModelsACDC.jl** to support hierarchical droop optimization.
- Joint optimization of **Cost minimization** and **DC voltage stability**.
- Dynamic adjustment of MMC operating points post-disturbance.
- Benchmark system: Modified Nordic 32 AC network with four-terminal MTDC integration.

## How to Use

1. Clone the repository:
    ```bash
    git clone https://github.com/hongjin7/PMACDC-HD.git
    cd PMACDC-HD.jl
    ```
2. Install [Julia](https://julialang.org/) (v1.7 or above) and the required dependencies listed in `Project.toml`.
3. Choose the corresponding control strategy branch:
    ```bash
    git checkout active-power-control
    git checkout adaptive-droop-control
    git checkout vf-droop-control
    ```
4. Run the run.jl to compute steady-state operating points.

## Dependencies

- [Julia](https://julialang.org/) ≥ 1.7
- [PowerModels.jl](https://github.com/lanl-ansi/PowerModels.jl)
- [PowerModelsACDC.jl](https://github.com/lanl-ansi/PowerModelsACDC.jl) (forked version)
- [JuMP.jl](https://jump.dev/JuMP.jl/stable/)
- Nonlinear optimization solvers (e.g., Ipopt, Juniper)

## Citation

If you use this repository or the developed models in your work, please cite:

H. Du, T. B. Hashfi, R. Prasad, P. P. Vergara, P. Palensky, and A. Lekić,  “Optimal Droop Control Strategy for Coordinated Voltage Regulation and Power Sharing in Hybrid AC-MTDC Systems,” *arXiv preprint* arXiv:2505.03651, 2025. Available: [https://arxiv.org/abs/2505.03651](https://arxiv.org/abs/2505.03651)


### BibTeX

```bibtex
@misc{du2025optimal,
  title={Optimal Droop Control Strategy for Coordinated Voltage Regulation and Power Sharing in Hybrid AC-MTDC Systems},
  author={Hongjin Du and Tuanku Badzlin Hashfi and Rashmi Prasad and Pedro P. Vergara and Peter Palensky and Aleksandra Leki{\'c}},
  year={2025},
  eprint={2505.03651},
  archivePrefix={arXiv},
  primaryClass={eess.SY}
}

