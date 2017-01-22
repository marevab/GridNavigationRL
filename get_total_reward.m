function [total_reward] = get_total_reward( optimal_policy, reward )

%
% This functions enables to compute the total reward obtain bya plying an
% optimal policy.
%   - optimal_policy : vector of size 100. The nth value corresponds to the
%    action to take for the nth step.
%   - reward : 100 by 4 matrix which contains the rewards
% Returns : 
%   - total_reward : sum of the rewards obtained
%

% Initialize the total reward
total_reward = 0;
state = 1;

while state ~= 100
    
    % Get the reward 
    total_reward = total_reward + reward(state, optimal_policy(state));
    
    % Update the state 
    state = get_next_state(state, optimal_policy(state));

end

