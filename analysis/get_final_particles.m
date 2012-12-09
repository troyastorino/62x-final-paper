function [particles, chem_pose, delta_t, end_ind] = get_final_particles(...
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

