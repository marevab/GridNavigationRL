% This script enables to apply the Q-learning algorithm for the Task 2.

% We assume that the variables of 'qeval.mat' are already loaded in the
% workspace :
%   reward : 100 by 4 matrix which contains the reward for each state and action

%% Parameters of the Q-learning algorithm

% Define the discount rate
gamma = 0.9;

% Choice of the exploration probability
explo_prob_fct = @explo_proba_2;

% Maximum number of trials
nb_trials_max = 3000;

%% Q-learning algorithm

tic
% Initialization of the trial number
nb_trials = 0;
% Initialize the Q function
Q = zeros(100,4);
next_Q = zeros(100, 4);
% Parameters for the convergence criteria
ewma = 100;
thres = 0.001;

% As long as Q doesn't converge and the number of trials is under 3000
while ewma > thres && nb_trials < nb_trials_max
  
    Q = next_Q;
    
    % Run one trial
    next_Q = trial(Q, reward, 1, explo_prob_fct, 1, 1, gamma);
    
    % Update the number of trials
    nb_trials = nb_trials + 1;
    
    % Compute the mean squared difference between the next and the
    % current Q-functions
    msd = (next_Q - Q).^2;
    if nb_trials == 1
        ewma = mean(msd(:));
    end
    ewma = 0.95 * ewma + 0.05 * mean(msd(:));
end

% Take the last Q-function computed
Q = next_Q;

% Take the maximum value of the Q function to obtain the optimal policy
[~, qevalstates] = max(Q, [], 2);

computation_time = toc;
disp(['Run ends with ', int2str(computation_time), ' seconds']);

% Plot the optimal policy
plot_grid(qevalstates, reward)

