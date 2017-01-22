load('task1.mat');
gamma = 0.9;

% Initialize the Q function
Q_opt_value_iter = zeros(100,4);

% Run it for 1000 runs (we assume that the convergence is reached for 1000
% runs)
for trial = 1:1000
    
    % For every state-action pair
    for s = 1:99
        
        % Actions available at state s
        actions_available = find(reward(s,:) ~= -1);
        
        for a = actions_available
            
            % Define the next state according to the chosen action
            next_s = get_next_state(s,a);
            % Actions available at next state
            actions_available_next_step = find(reward(next_s,:) ~= -1);
            % Q updating
            Q_opt_value_iter(s,a) = reward(s,a) + gamma * max(Q_opt_value_iter(next_s,actions_available_next_step));
        end
        
    end
end

% Extract the optimal policy 
[~, optimal_policy] = max(Q_opt_value_iter, [], 2);

% Plot it on a grid 
plot_grid(optimal_policy, reward);
title('Optimal trajectory of the robot with gamma equal to 0.9')