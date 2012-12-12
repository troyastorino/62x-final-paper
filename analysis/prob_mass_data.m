%% Read in data
[stochastic, greedy] = get_all_data();

%% Calculate probabilitiy masses
n = length(stochastic);

init_mass_g = zeros(n, 1);
init_mass_s = zeros(n, 1);
final_mass_g = zeros(n, 1);
final_mass_s = zeros(n, 1);
delta_t_g = zeros(n, 1);
delta_t_s = zeros(n, 1);

trial_time = 35;

for i = 1:n
    [final_particles, chem_pose, delta_t_g(i)] = get_final_particles(...
        greedy(i), trial_time);
    [~, init_mass_g(i), final_mass_g(i)] = ...
        localization_circle_metric(final_particles, chem_pose, delta_t_g(i));

    [final_particles, chem_pose, delta_t_s(i)] = get_final_particles(...
        stochastic(i), trial_time);
    [~, init_mass_s(i), final_mass_s(i)] = ...
        localization_circle_metric(final_particles, chem_pose, delta_t_s(i));
end

%% Display probability masses
disp('Probability masses')

init_mass_g
final_mass_g
ratio_g = final_mass_g ./ init_mass_g;
rate_g = ratio_g ./delta_t_g

init_mass_s
final_mass_s
ratio_s = final_mass_s ./ init_mass_s;
rate_s = ratio_s ./delta_t_s

ratio = rate_s ./ rate_g

%% Calculate whether inital mass is any different than final mass
disp('Statistics of ratio of final to init prob mass for greedy')
mu_g = mean(ratio_g)
s_g = std(ratio_g) / sqrt(n)
t_g = (mu_g - 1) / s_g
p_g = 2*(1-tcdf(abs(t_g), n-1))

disp('Statistics of ratio of final to init prob mass for stochastic')
mu_s = mean(ratio_s)
s_s = std(ratio_s) / sqrt(n)
t_s = (mu_s - 1) / s_s
p_s = 2*(1-tcdf(abs(t_s), n-1))

%% Calculate whether inital mass is any different than final mass without trial 3
disp('Statistics of ratio of final to init prob mass for greedy')
ratio_g_wo_3 = ratio_g;
ratio_g_wo_3(3) = [];
mu_g = mean(ratio_g_wo_3)
s_g = std(ratio_g_wo_3) / sqrt(n)
t_g = (mu_g - 1) / s_g
p_g = 2*(1-tcdf(abs(t_g), n-1))

disp('Statistics of ratio of final to init prob mass for stochastic')
ratio_s_wo_3 = ratio_s;
ratio_s_wo_3(3) = [];
mu_s = mean(ratio_s_wo_3)
s_s = std(ratio_s_wo_3) / sqrt(n)
t_s = (mu_s - 1) / s_s
p_s = 2*(1-tcdf(abs(t_s), n-1))

