

% Read in Data file
function [time,pos,posquat,mu,C,newData] = Estimator2Mat(fname)

newData = dlmread(fname,'\t',1,0);
time = newData(:,1);
pos = newData(:,2:4);
posquat = newData(:,5:8);
mu = newData(:,9:11);
C = newData(:,12);
resistance = zeros(size(newData,1),1);
for i = 2:length(resistance)
    this_resistances = newData(i,13:end);
    this_resistances(this_resistances == 0 | this_resistances > 1e5) = [];
    resistance(i) = mean(this_resistances);
end