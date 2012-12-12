%% Read in data
[stochastic, greedy] = get_all_data();

%% Get set of points
n = length(stochastic);
stochastic_areas = zeros(n,1);
greedy_areas = zeros(n,1);

area = pi*4.5^2;

for i=1:n
    pose_s = stochastic(i).pose;
    [~, stochastic_areas(i)] = convhull(pose_s(:,1), pose_s(:,2));
    
    pose_g = greedy(i).pose;
    [~, greedy_areas(i)] = convhull(pose_g(:,1), pose_g(:,2));
end

stochastic_percentage_area = stochastic_areas / area
greedy_percentage_area = greedy_areas / area