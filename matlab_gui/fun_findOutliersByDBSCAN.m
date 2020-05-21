function [OL, Y] = fun_findOutliersByDBSCAN(X, minpts, segRatio, polyOrders, plt)

kD = pdist2(X,X,'euc','Smallest',minpts); % The minpts smallest pairwise distances

%% fit 2 curve for last part of data
yy = sort(kD(end,:));
xx = 1:length(yy);
m = round(length(yy)-length(yy)/segRatio);
yy = yy(m:end);
xx = xx(m:end);

if plt.on
    hAx = subplot(131, 'parent', plt.hFig);
    hAx.Color = 'k';
    plot(xx, yy, '-o', 'markersize', 4); hold on

    title('k-distance graph')
    xlabel(['Points sorted with ', num2str(minpts), ' nearest distances'])
    ylabel([num2str(minpts), 'th nearest distances'])
    grid
end

for n = 1:minpts
    n1 = length(yy)-n;
    y1 = yy(n1:end);
    x1 = xx(n1:end);
    p = polyfit(x1, y1, polyOrders(1));
    y1v = polyval(p, x1);
    
    y2 = yy(1:n1);
    x2 = xx(1:n1);
    p2 = polyfit(x2, y2, polyOrders(2));
    y2v = polyval(p2, x2);
    
    s(n) = sum((y1v-y1).^2)+sum((y2v-y2).^2);
end
    
[~, idx] = min(s);
n1 = length(yy) - idx;
y1 = yy(n1:end);
x1 = xx(n1:end);
p = polyfit(x1, y1, polyOrders(1));
y1v = polyval(p, x1);

y2 = yy(1:n1);
x2 = xx(1:n1);
p2 = polyfit(x2, y2, polyOrders(2));
y2v = polyval(p2, x2);

if plt.on
    plot(x1, y1v, 'r', 'linewidth', 2);
    plot(x2, y2v, 'g', 'linewidth', 2);
end

idx = n1;
if p(1)<1
    epsilon = max(yy);
else
    epsilon = y2(idx);
end

if plt.on
    hAx = subplot(132, 'parent', plt.hFig);
    plot(s)
    title('Knee point finding')
    xlabel(['Knot position'])
    ylabel('Mean square error')
    grid
end

%% dbscan;
epsilon = round(epsilon);
labels = dbscan(X,epsilon,minpts);
OL = X(labels==-1, :);
Y = X(labels~=-1, :);

if plt.on
    hAx = subplot(133, 'parent', plt.hFig);
    gscatter(X(:,1),X(:,2),labels);
    grid
    hold on
end