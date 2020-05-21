clearvars

load('Metric')
iMetric = 3; % Upper Point
iStructList = [1 3 9]; % bladder
nS = length(iStructList);
eps = [30 25 20];
eps = [30 35 35];

figure(1), clf
for iS = 1:nS
    iStruct = iStructList(iS);
    
X(:, 1) = Metric(iMetric).Struct(iStruct).Dose;
X(:, 2) = Metric(iMetric).Struct(iStruct).Vol;

minpts = round(size(X, 1)/10);
minpts = 20;

kD = pdist2(X,X,'euc','Smallest',minpts); % The minpts smallest pairwise distances
% Plot the k-distance graph.

junk = sort(kD(end,:));
m = round(length(junk)/2);
junk = junk(m:end);
subplot(nS, 2, 1+(iS-1)*2)
plot(junk, '-.'); hold on

dj = diff(junk);
idx = find(dj>5, 1, 'first');

if isempty(idx)
    epsilon = max(junk);
else
    epsilon = junk(idx);
end
plot(idx, junk(idx), 'ro');

title('k-distance graph')
xlabel('Points sorted with 50th nearest distances')
ylabel('5th nearest distances')
grid

% epsilon = eps(iS);
labels = dbscan(X,epsilon,minpts);
subplot(nS, 2, 2+(iS-1)*2)
gscatter(X(:,1),X(:,2),labels);
title('epsilon = 2 and minpts = 50')
grid

clear X;

end