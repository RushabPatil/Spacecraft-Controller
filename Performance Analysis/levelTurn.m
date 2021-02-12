%% F-35B Lightning 2 - Level Turn Analysis
clear
%% Constants
W = 266893.3;       %Maximum Weight
T_max = 169032.42;  %Maximum thrust available
C_D_0 = 0.007;      %Zero Lift Drag - from presentation
C_L_max = 0.65;      %Maximum Lift coefficient - from presentation
rho_sl = 1.225;     %Density at sea level
%v = 60;             %Velocity of 60 m/s at given thrust specification
e = 0.85761;        %Oswald Efficiency Factor - from presentation
S = 42.7;           %Wing's Area
b = 10.7;           %Wingspan
g = 9.8;            %accelearation due to gravitation

result = [0, 0, 0, 0]; %[velocity, n_max_thrust, n_max_alpha, R_min]

for v = 54:0.5:560
    
    %% Preliminary Calculations 
    AR = b^2/S;             % Wing's Aspect Ratio
    Q = (1/2)*rho_sl*(v^2); % Dynamic Pressure
    K = (4/3)*(1/(pi*e*AR));% Induced Drag
    
    %% Conditions for finding minimum radius for level turn
    n_max_thrust = sqrt((Q/(K*(W/S))*(T_max/W - ((Q*C_D_0)/(W/S)))));
    n_max_alpha = Q*C_L_max/(W/S);
    n_max_values = [n_max_thrust, n_max_alpha];
    
    %% Sharpest Turn calculation
    n_max = min(n_max_values);
    R_min = v^2/(g*sqrt(n_max^2 - 1));
    
    %% Concatenation:
    out = [v, n_max_thrust, n_max_alpha, R_min];
    result = vertcat(result, out);
    
end

%% Plotting section
plot(result(:,1), result(:, 2), 'b-');
hold on
% Add a red line.
plot(result(:,1), result(:, 3), 'r-');
xlabel('Velocity')
ylabel('nmax')
legend({'nmax-thrust','nmax-alpha'},'Location','northeast')

