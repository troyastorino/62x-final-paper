function [ val ] = kl_divergence_from_uniform_metric( ...
    final_particles, chem_pose, delta_t)
%UNTITLED12 Summary of this function goes here
%   Detailed explanation goes here

uniform_dist = get_initial_particles(final_particles);

val = kl_divergence(uniform_dist, final_particles(:,3));
end

