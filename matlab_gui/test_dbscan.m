clearvars
close all

load('lidar_subset.mat') 
X = lidar_subset;

xBound  = 20; % in meters
yBound  = 20; % in meters
zLowerBound = 0; % in meters
% Crop the data to contain only points within the specified region.

indices = X(:,1) <= xBound & X(:,1) >= -xBound ...
    & X(:,2) <= yBound & X(:,2) >= -yBound ...
    & X(:,3) > zLowerBound;
X = X(indices,:); 
% Visualize the data as a 2-D scatter plot. Annotate the plot to highlight the vehicle.

scatter(X(:,1),X(:,2),'.');
annotation('ellipse',[0.48 0.48 .1 .1],'Color','red')
minpts = 50;

kD = pdist2(X,X,'euc','Smallest',minpts); % The minpts smallest pairwise distances
% Plot the k-distance graph.

junk = sort(kD(end,:));
figure
plot(junk);
title('k-distance graph')
xlabel('Points sorted with 50th nearest distances')
ylabel('50th nearest distances')
grid


epsilon = 2;
labels = dbscan(X,epsilon,minpts);
figure
gscatter(X(:,1),X(:,2),labels);
title('epsilon = 2 and minpts = 50')
grid

figure
ind = find(labels == -1);
scatter(X(ind, 1),X(ind, 2),'.');
