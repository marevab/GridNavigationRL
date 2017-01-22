function [next_s] = get_next_state(s,a)

%
% This function enables to get the next state according to the current
% state and the following action.
%   - s : current state
%   - a : current action
% Returns :
%   - next_s : next state

% Go up
if a == 1
    next_s = s - 1;
% Go to the right
elseif a == 2
    next_s = s + 10;
% Go down
elseif a == 3
    next_s = s + 1;
% Go to the right
else
    next_s = s - 10;
end


end

