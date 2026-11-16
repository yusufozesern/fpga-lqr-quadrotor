%% linearize_plant.m
% Linearizes the Simulink model around hover operating point
% Run AFTER the Simulink model is built

modelName = 'quadrotor_lqr_v3';

% Open model
if ~bdIsLoaded(modelName)
    open_system(modelName);
end

% Operating point: state-zero (hover)
io(1) = linio([modelName '/u1_total'], 1, 'openinput');
io(2) = linio([modelName '/u_split'], 2, 'openinput');
io(3) = linio([modelName '/u_split'], 3, 'openinput');
io(4) = linio([modelName '/u_split'], 4, 'openinput');
io(5) = linio([modelName '/Quadrotor Plant'], 1, 'openoutput');
setlinio(modelName, io);

op = operpoint(modelName);
op.States.x = zeros(8,1);   % equilibrium

% Linearize
linsys = linearize(modelName, io, op);

A = linsys.A;
B = linsys.B;

% Save for design_lqr
save('plant_linearized.mat', 'A', 'B');

fprintf('\nLinearization complete:\n');
fprintf('  A size: %dx%d\n', size(A,1), size(A,2));
fprintf('  B size: %dx%d\n', size(B,1), size(B,2));
fprintf('  Controllable: %d\n', rank(ctrb(A,B)) == size(A,1));