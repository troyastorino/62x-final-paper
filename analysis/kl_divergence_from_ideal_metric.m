function [ val ] = kl_divergence_from_ideal_metric( ...
    final_particles, chem_pose, delta_t)
%UNTITLED12 Summary of this function goes here
%   Detailed explanation goes here

sigma = eye(2);

% create 'ideal' distribution
ideal = mvnpdf([final_particles(:,1) final_particles(:,2)], ...
    chem_pose, sigma);
ideal = ideal/sum(ideal);

val = kl_divergence(ideal, final_particles(:,3));
end

