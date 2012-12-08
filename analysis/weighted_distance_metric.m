function [ weighted_dist ] = weighted_distance_metric(...
    final_particles, chem_pose, delta_t)
%UNTITLED14 Summary of this function goes here
%   Detailed explanation goes here

weighted_dist = 0;
for i=1:length(final_particles(:,1))
    dist = norm(final_particles(i, 1:2) - chem_pose);
    weighted_dist = weighted_dist + final_particles(i,3) * dist;
end