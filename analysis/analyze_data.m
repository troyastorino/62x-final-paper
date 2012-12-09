function [ p,t ] = analyze_data( metric_fn, stochastic_trials, greedy_trials)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

%% Constants
trial_time = 35;


%% Read in and evaluate all the data
num_trials = length(stochastic_trials);
stochastic = zeros(num_trials, 1);
greedy = zeros(num_trials, 1);
for i = 1:num_trials
    % stochastic trial
    [final_particles, chem_pose, delta_t] = get_final_particles(...
        stochastic_trials(i), trial_time);
    stochastic(i) = metric_fn(final_particles, chem_pose, delta_t);
    
    % greedy trial
    [final_particles, chem_pose, delta_t] = get_final_particles(...
        greedy_trials(i), trial_time);
    greedy(i) = metric_fn(final_particles, chem_pose, delta_t);
end


%% calculate ratios and statistics on ratios
ratio = stochastic ./ greedy;
rbar = mean(ratio); % population mean
n = length(ratio);
s = std(ratio) / sqrt(n); % sample standard deviation of the mean

%% Display output of statistical tests
disp('t-statistic of the difference of ratio from 1.2')
t = (rbar - 1.2) / s
disp('probability of a larger t-statistic if ratio actually 1.2')
p = 1-tcdf(t, n-1)

disp('t-statistic of the difference of ratio from 1')
t_centered = (rbar - 1) / s
disp('probability of a larger magnitude t-statistic if ratio actually 1')
p_centered = (1-tcdf(abs(t_centered), n-1))*2

%% Plot output
figure; hold on;
plot(ratio,'*b','LineWidth',2);
plot([1:length(ratio)],mean(ratio)*ones(1,length(ratio)),'b','LineWidth',2);
plot([1:length(ratio)],(mean(ratio)+std(ratio)/3)*ones(1,length(ratio)),'m');
plot([1:length(ratio)],(mean(ratio)-std(ratio)/3)*ones(1,length(ratio)),'m');

xlabel('Source Location');
ylabel('Ratio (Stochastic/Greedy)');
legend('Ratio (Stochastic/Greedy)','Sample mean','Sample Mean standard error',...
    'Location','SE');

h_xlabel = get(gca,'XLabel');
h_ylabel = get(gca, 'YLabel');
h_lines = findall(get(gca,'Children'),'Type','Line');
axescolor='black';
set(h_xlabel,'FontSize',16,'Color',axescolor)
set(h_ylabel,'FontSize',16,'Color',axescolor)

set(gca,'FontSize',[14],'FontWeight','Bold','XColor',axescolor,'YColor',axescolor,'Linewidth',1);



end

function [particles, chem_pose, delta_t] = get_final_particles(...
    trial_struct, trial_time)
% trial time is the time since the trial began (in minutes) to get the
% particles for.  If not provided, gets the last set of particles
% available. Also returns the actual amount of time that has elapsed over
% the course of the trial

particle_log = trial_struct.particle_log;
chem_pose = trial_struct.chem_pose;
time = trial_struct.time;

% Read in trial begin time:
begin_time = time(1);

% Calculate trial end time:
if nargin < 1
    end_ind = length(particle_log);
else
    end_ind = find(time>=begin_time+trial_time*6e7,1);
end
end_time = time(end_ind);

% calculate the actual time elapsed during the trial up to the measurement
% point.  Measured in minutes
delta_t = (end_time - begin_time)*1e-6/60;
if delta_t > trial_time + 5
    delta_t = trial_time;
end

% Get particle probabilities at the trial end time:
particles = [particle_log(:,1), particle_log(:,2),particle_log(:,end_ind+2)];

end

