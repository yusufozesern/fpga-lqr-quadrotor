%% init_params.m
% Khati et al. (2024) Table I — quadrotor parameters
% Initial conditions and references for LQR control test

%% Quadrotor physical parameters
params.Ix  = 7.5e-3;   % roll inertia [kg.m^2]
params.Iy  = 7.5e-3;   % pitch inertia [kg.m^2]
params.Iz  = 1.3e-2;   % yaw inertia [kg.m^2]
params.m   = 0.65;     % mass [kg]
params.g   = 9.81;     % gravity [m/s^2]
params.l   = 0.23;     % arm length [m]
params.b   = 3.13e-5;  % thrust coefficient
params.d   = 7.5e-7;   % drag coefficient

% Drag/damping coefficients
params.K1z = 6.354e-4;
params.K2x = 5.56e-4;
params.K2y = 5.56e-4;
params.K2z = 6.354e-4;

% Hover thrust (precomputed numeric value)
params.hover_thrust = params.m * params.g;   % = 6.3765 N

%% Initial conditions (8-state vector)
% State: x = [z, zdot, phi, phidot, theta, thetadot, psi, psidot]
ic.x0 = [0; 0; 0.6; 0; 0.5; 0; 0.35; 0];

%% Reference signals
ref.z   = 30;
ref.phi = 0;
ref.theta = 0;
ref.psi = 0;
ref.x_ref = [ref.z; 0; ref.phi; 0; ref.theta; 0; ref.psi; 0];

%% Simulation settings
Ts = 1e-3;    % sample time [s]
Tend = 10;    % stop time [s]
%% Saturation limits
sat.u1_upper = 13.62;  % Max LQR thrust correction (total ≤ 20 N)
sat.u1_lower = -6.38;  % Min (zero total thrust)
sat.tau_max  = 0.5;    % Max torque ≈ l × dF

%% Workspace check
fprintf('Parameters loaded:\n');
fprintf('  Hover thrust = %.4f N\n', params.hover_thrust);
fprintf('  Initial conditions: phi0=%.2f, theta0=%.2f, psi0=%.2f rad\n', ...
    ic.x0(3), ic.x0(5), ic.x0(7));
fprintf('  Sample time: %.4f s\n', Ts);