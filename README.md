# FPGA-Based LQR Control Implementation for Quadrotor UAV Stabilization

Paper source, simulation files and FPGA implementation reports.

## Structure

- `paper/` : LaTeX source (`paper.tex`) and compiled PDF
- `figs/` : figures used in the paper
- `matlab/` : LQR design scripts, linearized plant, controller data and Simulink model (`quadrotor_lqr_v3.slx`)
- `data/` : FPGA-in-the-loop simulation data (`fil_simulation_data.mat`)
- `data/vivado/` : post-implementation utilization, timing and power reports

## Usage

Run `init_params.m`, `linearize_plant.m` and `design_lqr.m` in `matlab/`, then open `quadrotor_lqr_v3.slx`.

Author: Yusuf Özeser
