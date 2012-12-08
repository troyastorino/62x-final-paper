function [ divergence ] = kl_divergence( target_distribution, actual_distribution)
%kl_divergence Takes the KL divergence of two functions
%   The two arguments should be represented as 1-dimensional pdfs. Both
%   vectors should have the same length

target_distribution = target_distribution./sum(target_distribution);
actual_distribution = actual_distribution./sum(actual_distribution);

divergence = sum(target_distribution.*log(target_distribution./actual_distribution));



end

