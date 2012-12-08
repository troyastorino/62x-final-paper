close all
clear all

disp('Localization circle:')
analyze_data(@localization_circle_metric);

disp('Localization circle without trial 3:')
analyze_data(@localization_circle_metric,0);

disp('KL divergence from uniform, i.e. ratio of information gain rate:')
analyze_data(@kl_divergence_from_uniform_metric);

disp('KL divergence from uniform without trial 3:')
analyze_data(@kl_divergence_from_uniform_metric,0);

disp('Weighted distance:')
analyze_data(@weighted_distance_metric,0);

disp('Weighted distance without trial 3:')
analyze_data(@weighted_distance_metric,0);

disp('KL divergence from "ideal" posterior:')
analyze_data(@kl_divergence_from_ideal_metric);

disp('KL divergence from "ideal" posterior without trial 3:')
analyze_data(@kl_divergence_from_ideal_metric,0);

