function [total_reward] = plot_grid(optimal_policy, reward)

%
% This function enables to plot several grid with the optimal policy found by
% Q-learning algorithm for several runs.
%   - optimal_policy : 100 by (nb_runs) matrix
%   - reward : 100 by 4 matrix which contains the rewards
% Returns :
%   - a figure with the trajectory of the robot with the total reward
%   written
%   - total_reward : total reward obtained
%

% Get the number of runs
nb_runs = length(optimal_policy(1,:));


% Define a figure
figure
for i = 1:nb_runs
    
    % Initialize the total reward
    total_reward = 0;
    
    if nb_runs > 1
        subplot(2, nb_runs/2, i)
    end
    
    grid on
    axis([0 10 0 10])
    
    state = 1;
    n = 0;
    while( state ~= 100 && n < 100)
        
        % Convert the state into coordinates x and y
        [y,x] = ind2sub([10,10],state);
        
        % Update the total reward
        total_reward = total_reward + reward(state, optimal_policy(state, i));
        
        % Define the next step and the symbol that indicates the direction
        if optimal_policy(state,i) == 1
            text(x - 0.5, 10 - y + 0.5, '^')
            state = state - 1;
        elseif optimal_policy(state,i) == 2
            text(x - 0.5, 10 - y + 0.5, '>')
            state = state + 10;
        elseif optimal_policy(state,i) == 3
            text(x - 0.5, 10 - y + 0.5, 'v')
            state = state + 1;
        else
            text(x - 0.5, 10 - y + 0.5, '<')
            state = state - 10;
        end
        
        n = n + 1;
        
    end
    
    % Indicate the the first and last state
    text(0.35,9.25, '*', 'color', 'g', 'FontSize', 30);
    text(9.35,0.25, '*','color', 'r', 'FontSize', 30);
    
    % If the goal is reached, display the total reward
    if state == 100
        text(7, 9, int2str(total_reward), 'FontSize', 15);
    end
    
end


end

