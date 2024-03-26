V = 5;
T = 1;
N = 10;
N_2 = 10;

% Initialilze angles (same size as time)
psi_i = linspace(-60, 60, N); % CHECK TIME + 1
theta_j = linspace(-40, 40, N);

psi_b = linspace(-27, 27, N_2); 

tvec = 0:0.01:T; % generates points between start and endpoint
tvec2 = 0:0.01:T; 

% Initialize the figure outside of the loop
figure
xlabel('X')
ylabel('Y')
zlabel('Z')

for k = 1:10
    for i = 1:N
        x_T = V * T * cosd(psi_i(i)); 
        y_T = V * T * sind(psi_i(i)); 
        z = V * sind(theta_j(k));
        
        wpts = [0, x_T; 0, y_T; 0, z];
        tpts = [0, T];
        [q, ~, ~, ~] = cubicpolytraj(wpts, tpts, tvec, 'VelocityBoundaryCondition', [V, x_T; 0, y_T; 0, z]);
        
        for j = 1:N_2
            x_2T = x_T + V * T * cosd(psi_b(j) + psi_i(i));  
            y_2T = y_T + V * T * sind(psi_b(j) + psi_i(i));
            z_2T = (k-5) * ones(size(x_2T(1, :)));
            
            wpts2 = [x_T, x_2T; y_T, y_2T; z, z_2T];
            [q2, ~, ~, ~] = cubicpolytraj(wpts2, tpts, tvec2, 'VelocityBoundaryCondition', [x_T, x_2T; y_T, y_2T; z, z_2T]);
           
            % Plot trajectories
            plot3(q(1, :), q(2, :), q(3, :),'-r');
            hold on;
            plot3(q2(1,:), q2(2, :), q2(3, :),'-b');
            hold on;
        end
    end
end
