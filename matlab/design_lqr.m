%% design_lqr.m
% Designs LQR controller from linearized plant
% Run AFTER linearize_plant.m

% Load A, B
load('plant_linearized.mat', 'A', 'B');

% LQR weights
% State penalty: prioritize tracking z, phi, theta, psi (positions)
Q = diag([1, 2, 5, 1, 5, 1, 5, 1]);
% Input penalty: thrust cheaper (already required for hover), torques mid
R = diag([0.1, 1, 1, 1]);

% Compute LQR gain
K = lqr(A, B, Q, R);

% Closed-loop verification
Acl = A - B*K;
eig_cl = eig(Acl);

% Save K for Simulink
save('controller_data.mat', 'K', 'A', 'B', 'Q', 'R');

fprintf('\nLQR design complete:\n');
fprintf('  K size: %dx%d\n', size(K,1), size(K,2));
fprintf('  Max closed-loop eigenvalue real part: %.4f (negative = stable)\n', ...
    max(real(eig_cl)));
fprintf('  K matrix saved to controller_data.mat\n');