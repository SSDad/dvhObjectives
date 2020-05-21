clearvars
close all

load('Metric')
iMetric = 3; % Upper Point
iStructList = [1 3 9]; % [bladder bowel rectum];
nS = length(iStructList);

segRatio = 4;
polyOrders = [1 3];
plt.on = 1;
plt2.on = 1;

for iS = 3%:nS
    iStruct = iStructList(iS);
    
    X(:, 1) = Metric(iMetric).Struct(iStruct).Dose;
    X(:, 2) = Metric(iMetric).Struct(iStruct).Vol;

    minpts = round(size(X, 1)/10);
    minpts = min(25, minpts);

    if plt.on
        junk = Metric(iMetric).uniqStruct(iStruct);
        plt.structName = junk{1};
        plt.hFig = figure('Name', plt.structName, ...
                            'MenuBar',            'none', ...
                        'Toolbar',              'none', ...
                        'NumberTitle',      'off', ...
                        'Units',                 'normalized',...
                        'Position',             [0.1 0.5 0.8 0.4],...
                        'Color',                 'w', ...
                        'Visible',               'on');
    end
    [OL, Y] = fun_findOutliersByDBSCAN(X, minpts, segRatio, polyOrders, plt);
    clear X;
    
    % evel clustering
    cret = {'CalinskiHarabasz'
    'silhouette'
    'DaviesBouldin'
    'gap'};
    countPt = Metric(iMetric).Struct(iStruct).countPt;
    if plt2.on
        junk = Metric(iMetric).uniqStruct(iStruct);
        plt2.structName = junk{1};
        plt2.hFig = figure('Name', plt.structName, ...
                            'MenuBar',            'none', ...
                        'Toolbar',              'none', ...
                        'NumberTitle',      'off', ...
                        'Units',                 'normalized',...
                        'Position',             [0.1 0.1 0.8 0.4],...
                        'Color',                 'w', ...
                        'Visible',               'on');
    end

    [OptK] = fun_evalClustering(Y, cret, countPt, plt2);
    
    % kmeans
    countPt = Metric(iMetric).Struct(iStruct).countPt;
    plt3.on = 1;
    if plt2.on
        junk = Metric(iMetric).uniqStruct(iStruct);
        plt3.structName = junk{1};
        plt3.hFig = figure('Name', plt.structName, ...
                            'MenuBar',            'none', ...
                        'Toolbar',              'none', ...
                        'NumberTitle',      'off', ...
                        'Units',                 'normalized',...
                        'Position',             [0. 0.1 1 0.4],...
                        'Color',                 'w', ...
                        'Visible',               'on');
    end
    
    OptK = [OptK round(mean(countPt))];
    nk = length(OptK);
    ttl = cret;
    ttl{nk} = 'meanPatientCount';
    for m = 1:nk
        k = OptK(m);
        [ind, C] = kmeans(Y, k, 'Replicates', 10);
        hAx = subplot(1, nk, m, 'parent', plt3.hFig);
        scatter(Y(:, 1), Y(:, 2));
        hold on
        for n = 1:k
            xc = Y(ind==n, 1);
            yc = Y(ind==n, 2);
            kb = boundary(xc, yc);
            plot(xc(kb), yc(kb)); 
        end
        title(ttl{m});
    end
    
end