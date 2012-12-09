function plot_posteriors( stochastic, greedy )
%UNTITLED21 Summary of this function goes here
%   Detailed explanation goes here

h = figure;
set(h, 'Position',[0 0 200 700])

addpath('SubAxis');

num_trials = length(stochastic);
for i=1:num_trials
    %subplot(num_trials, 2, 2*i-1);
    subaxis(num_trials, 2, 2*i-1, 'Spacing', 0, 'Padding', 0, 'Margin', 0);
    plot_final_particles(greedy(i));
    %subplot(num_trials, 2, 2*i);
    subaxis(num_trials, 2, 2*i, 'Spacing', 0, 'Padding', 0, 'Margin', 0);
    plot_final_particles(stochastic(i), greedy(i).chem_pose);
end

end

function plot_final_particles(trial_struct, desired_chem_pose)
[particles, chem_pose, delta_t, end_ind] = get_final_particles(...
    trial_struct, 35);

if nargin < 2
    R = eye(3);
else
    r = vrrotvec(horzcat(chem_pose, [0]), horzcat(desired_chem_pose, [0]));
    R = vrrotvec2mat(r);
end

% rotate particles and chem pose
for i=1:length(particles(:,1))
    particles(i,1:2) = rotate_vector(particles(i,1:2), R);
end
chem_pose = rotate_vector(chem_pose, R);

% rotate robot position
pose = trial_struct.pose;
for i=1:length(pose(:,1))
    pose(i,1:2) = rotate_vector(pose(i,1:2), R);
end

x_bounds = [min(particles(:,1))-1 max(particles(:,1))+1]; 
y_bounds = [min(particles(:,2))-1 max(particles(:,2))+1];

% draw particles
draw_particle_belief(particles);

% draw robot position
draw_robot(pose(1:end_ind,1:2));

% draw chemical position
plot(chem_pose(1), chem_pose(2), 'kd', 'MarkerSize', 5, 'LineWidth', 2, ...
    'Color', 'green')

% set bounds
xlim(x_bounds);
ylim(y_bounds);

axis square;
axis off;
end

function [x_rot] = rotate_vector(x, R)
% takes a length 2 vector, and rotates it using a 3x3 rotation matrxix
x = horzcat(x, [0]);
rot = R * x';
x_rot = rot(1:2);
end

function draw_particle_belief(particles)
marker_size = 1;

w_sorted = sort(particles(:,3),'descend');
top_w = w_sorted(find(cumsum(w_sorted) < 1/4, 1, 'last'));
bottom_w = w_sorted(find(cumsum(w_sorted) < 1/2, 1, 'last'));
top_inds = particles(:,3) >= top_w;
plot(particles(top_inds,1), particles(top_inds,2), '.r', 'MarkerSize', marker_size)
hold on;
mid_inds = top_w > particles(:,3) >= bottom_w;
plot(particles(mid_inds,1), particles(mid_inds,2), '.y', 'MarkerSize', marker_size)
bottom_inds = particles(:,3) < bottom_w;
plot(particles(bottom_inds,1), particles(bottom_inds,2), '.b', 'MarkerSize', marker_size)
end

function draw_robot(past_positions)
plot(past_positions(:,1), past_positions(:,2), 'k', 'LineWidth', 1)
hold on;
plot(past_positions(end,1), past_positions(end,2), 'kx', 'MarkerSize', 5,'LineWidth',3)
end