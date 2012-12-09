close all
clear all

%% Get data
[stochastic, greedy] = get_all_data();

%% Run with all trials
disp('Metric analysis with all trials')
analyze_with_metrics(stochastic, greedy);

%% Run without third trials
stochastic_without_3 = stochastic;
stochastic_without_3(3) = [];
greedy_without_3 = greedy;
greedy_without_3(3) = [];

disp('Metric analysis without source location 3')
analyze_with_metrics(stochastic_without_3, greedy_without_3);

%% Plot posteriors
plot_posteriors(stochastic, greedy)