function analyze_with_metrics( stochastic, greedy )
%UNTITLED19 Summary of this function goes here


%% Run localization metric analysis
disp('Localization circle:')
analyze_data(@localization_circle_metric, stochastic, greedy);

%% Run analysis of information gain
disp('KL divergence from uniform, i.e. ratio of information gain rate:')
analyze_data(@kl_divergence_from_uniform_metric, stochastic, greedy);

%% Run analysis of weighted distance metric
disp('Weighted distance:')
analyze_data(@weighted_distance_metric, stochastic, greedy);

%% Run analysis of KL divergence from ideal
disp('KL divergence from "ideal" posterior:')
analyze_data(@kl_divergence_from_ideal_metric, stochastic, greedy);

end

