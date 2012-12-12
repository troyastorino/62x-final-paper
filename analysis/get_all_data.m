function [ stochastic, greedy ] = get_all_data( use_third_trial )
% gets a struct with particle_log, chem_post, time, pose

%% Read in all the data
for i=1:18
    [ particle_log, chem_pose, time, pose ] = get_data( i );
    if (i==11)
        pose(9,:) = [];
        time(9) = [];
        particle_log(:,11) = [];
    end
    values(i) = struct('particle_log', particle_log, 'chem_pose', chem_pose, ...
        'time', time, 'pose', pose);
end

%% separate into stochastic and greedy trials
stochastic_trials = [1,3,5,8,10,11,13,15,18];
greedy_trials = [2,4,6,7,9,12,14,16,17];

if nargin < 1
    use_third_trial = 1;
end

if ~(use_third_trial)
    stochastic_trials(3) = [];
    greedy_trials(3) = [];
end

stochastic = values(stochastic_trials);
greedy = values(greedy_trials);


end

