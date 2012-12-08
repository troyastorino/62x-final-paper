function [ val ] = localization_circle_metric(final_particles, chem_pose, delta_t)
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here

radius = 1;

init_particles = get_initial_particles(final_particles);

final_mass = 0;
init_mass = 0;
for i = 1:length(final_particles)
    dist = norm(final_particles(i, 1:2) - chem_pose);
    if dist <= radius
        final_mass = final_mass + final_particles(i,3);
        init_mass = init_mass + init_particles(i);
    end
end


val = final_mass / init_mass / delta_t;