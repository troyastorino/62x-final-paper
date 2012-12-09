function [ particle_log, chem_pose, time, pose ] = get_data( trial_num )

% directory name for each trial:
dirname_mat = {
    'trials/2012-11-14_19-51-11/';
    'trials/2012-11-14_20-40-28/';
    'trials/2012-11-14_22-12-31/';
    'trials/2012-11-14_23-02-05/';
    'trials/2012-11-16_18-50-34/';
    'trials/2012-11-16_22-10-02/';
    'trials/2012-11-17_04-39-30/';
    'trials/2012-11-17_05-27-33/';
    'trials/2012-11-17_07-22-45/';
    'trials/2012-11-17_08-09-40/';
    'trials/2012-11-17_16-18-11/';
    'trials/2012-11-17_19-18-53/';
    'trials/2012-11-18_01-03-06/';
    'trials/2012-11-18_01-51-02/';
    'trials/2012-11-18_04-42-35/';
    'trials/2012-11-18_05-31-00/';
    'trials/2012-11-18_11-47-09/';
    'trials/2012-11-18_13-46-17/'};

% True source location for each trial:
chemical_position_mat = [
    0.3 6.59;
    0.3 6.59;
    -4.48 6.24;
    -4.48 6.24;
    -1.67 4.43;
    -3.77 8.47;
    1.42 -6.94;
    1.42 -6.94;
    -2.9 -4.66;
    -2.9 -4.66;
    -3.0 3.1;
    1.1 1.2;
    6.51 -.52;
    6.51 -.52;
    5.79 .03;        
    5.79 .03;
    2.25 -5.33;
    5.96 1.64];

dirname = dirname_mat{trial_num};
chem_pose = chemical_position_mat(trial_num,:);  

fname = [dirname 'estimator.log'];
fname_particles = [dirname 'particles.log'];

% Read in Estimator Log
[time,pose,posquat,mu,C,newData] = Estimator2Mat(fname);

% Read in Particle Filter Log
particle_log = dlmread(fname_particles);

end