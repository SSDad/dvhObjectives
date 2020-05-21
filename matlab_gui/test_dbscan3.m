clearvars

load('Metric')
iMetric = 3; % Upper Point
iStructList = [1 3 9]; % [bladder bowel rectum];
nS = length(iStructList);
eps = [30 25 20];
eps = [30 35 35];

figure(1), clf
for iS = 1:nS
    iStruct = iStructList(iS);
    
X(:, 1) = Metric(iMetric).Struct(iStruct).Dose;
X(:, 2) = Metric(iMetric).Struct(iStruct).Vol;

minpts = round(size(X, 1)/10);
minpts = min(25, minpts);

kD = pdist2(X,X,'euc','Smallest',minpts); % The minpts smallest pairwise distances

%% fit 2 curve for last half data
yy = sort(kD(end,:));
xx = 1:length(yy);
m = round(length(yy)/4);
yy = yy(m:end);
xx = xx(m:end);

subplot(nS, 3, 1+(iS-1)*3)
plot(xx, yy, '-o', 'markersize', 4); hold on

title('k-distance graph')
xlabel(['Points sorted with ', num2str(minpts), ' nearest distances'])
ylabel([num2str(minpts), 'th nearest distances'])
grid

n = 0;
for n = 1:minpts
    n1 = length(yy)-n;
    y1 = yy(n1:end);
    x1 = xx(n1:end);
    p = polyfit(x1, y1, 1);
    y1v = polyval(p, x1);
    
    y2 = yy(1:n1);
    x2 = xx(1:n1);
    p2 = polyfit(x2, y2, 3);
    y2v = polyval(p2, x2);
    
    s(n) = sum((y1v-y1).^2)+sum((y2v-y2).^2);
end
    
[~, idx] = min(s);
n1 = length(yy) - idx;
    y1 = yy(n1:end);
    x1 = xx(n1:end);
    p = polyfit(x1, y1, 1);
    y1v = polyval(p, x1);
    plot(x1, y1v, 'r', 'linewidth', 2);
    
    y2 = yy(1:n1);
    x2 = xx(1:n1);
    p2 = polyfit(x2, y2, 3);
    y2v = polyval(p2, x2);
    plot(x2, y2v, 'g', 'linewidth', 2);

idx = n1;
if p(1)<1
    epsilon = max(yy);
else
    epsilon = y2(idx);
end
plot(idx+m-1, y2(idx), 'md', 'linewidth', 2, 'markersize', 8);

subplot(nS, 3, 2+(iS-1)*3)
plot(s)
title('Knee point finding')
xlabel(['Knot position'])
ylabel('Mean square error')
grid

%% dbscan;
epsilon = round(epsilon);
labels = dbscan(X,epsilon,minpts);
subplot(nS, 3, 3+(iS-1)*3)
gscatter(X(:,1),X(:,2),labels);
title(Metric(iMetric).uniqStruct(iStruct))
grid

clear X s;

end