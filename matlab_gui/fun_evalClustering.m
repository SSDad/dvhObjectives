function    [OptK] = fun_evalClustering(Y, cret, countPt, plt)

k1 = min(countPt);
k2 = max(countPt);

for n = 1:length(cret)
    E = evalclusters(Y, 'kmeans', cret{n}, 'klist', [k1:k2]);

    hAx = subplot(1, length(cret), n, 'parent', plt.hFig);
    scatter(Y(:, 1), Y(:, 2));
    title(cret{n})
    hold on
    
    OptK(n) = E.OptimalK;
    for n = 1:OptK
        xc = Y(E.OptimalY==n, 1);
        yc = Y(E.OptimalY==n, 2);
        kb = boundary(xc, yc);
        plot(xc(kb), yc(kb)); 
    end
end    
