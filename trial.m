function [new_Q] = trial(Q, reward, state_init, explo_prob_fct, explo_prob_init, alpha_init, gamma)

%
% This function enables to run one trial.
%   Q : Q-function value, 100 by 4 matrix
%   rewards : 100 by 4 matrix which contains the rewards
%   state_init : initial state
%   explo_prob_fct : the probability function for exploring (handle
%   function)
%   explo_prob_init : initial probability for exploring
%   alpha_init : initial learning rate
%   gamma : discount rate
% Returns :
%   new_Q : new Q-function values after the trial, 100 by 4 matrix
%

% Initialize the exploration probability and the learning rate
explo_prob = explo_prob_init;
alpha = alpha_init;

% Initial state
s = state_init;

% Step number
k = 0;

while (s < 100) && (alpha > 0.005)
    
    %% Exploration or exploitation
    
    % Generate a random real number between 0 and 1
    random_value = rand();
    
    % Actions available at state s
    actions_available = find(reward(s,:) ~= -1);
    % Find the actions for which the Q function is maximum among the available actions at the
    % current state
    max_Q_idx = find(Q(s,actions_available) == max(Q(s,actions_available)));
    
    % Exploitation
    if random_value > explo_prob
        if length(max_Q_idx) == 1
            % If the maximum of the Q-function at the current state is reached
            % only once, take that one
            a = actions_available(max_Q_idx);
        else
            % If the maximum is reached for several actions, select randomly an
            % action among them (greedy policy)
            random_idx = randi(length(max_Q_idx));
            a = actions_available(max_Q_idx(random_idx));
        end
        % Exploration
    else
        if length(actions_available) - length(max_Q_idx) == 0
            % If there is no action available after taking out the actions
            % which correspond to the maximum value of Q, pick randomly an
            % action among available actions
            a = actions_available(randi(length(actions_available)));
            
        else
            % Take out the actions which correspond to the maximum value of
            % Q from the available actions
            for j = max_Q_idx
                actions_available(actions_available == j) = [];
            end
            % Select randomly an action among them
            a = actions_available(randi(length(actions_available)));
        end
    end
    
    %% Obtain the reward
    reward_obtained = reward(s,a);
    
    %% Define the next state according to the chosen action
    next_s = get_next_state(s,a);
    
    %% Update Q function
    
    % Actions available at next state
    actions_available_next_step = find(reward(next_s,:) ~= -1);
    % Q updating
    Q(s,a) = Q(s,a) + alpha * (reward_obtained + gamma * max(Q(next_s,actions_available_next_step)) - Q(s,a));
    
    %% Update parameters
    
    % Update the step number
    k = k + 1;
    
    % Update the state
    s = next_s;
    
    % Probability of exploration updating
    explo_prob = min(explo_prob_fct(k),1);
    % Learning rate updating
    alpha = explo_prob;
    
end

new_Q = Q;

end

