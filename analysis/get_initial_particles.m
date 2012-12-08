function [ initial_particles ] = get_initial_particles( final_particles )
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here
num_particles = length(final_particles(:, 1));

initial_particles = ones(num_particles, 1)./num_particles;

end

