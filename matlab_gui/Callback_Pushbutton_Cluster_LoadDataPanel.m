function Callback_Pushbutton_Cluster_LoadDataPanel(src, evnt)

hFig = ancestor(src, 'Figure');
data = guidata(hFig);
hPlotObj = data.Panel.View.Comp.hPlotObj;

iMetric = data.iMetric;
hRB = data.Panel.Structure.Comp.RB.hRB;

X = [];
Y = [];
nS = 0;
for n = 2:length(hRB)
    if hRB(n).Value
        iS = n-1;
        X = [X; data.Mtc.Metric(iMetric).Struct(iS).Dose];
        Y = [Y; data.Mtc.Metric(iMetric).Struct(iS).Vol];
        nS = nS+1;
    end
end

if nS == 1
    k = round(mean(data.Mtc.Metric(iMetric).Struct(iS).countPt));
else
    k = nS;
end

[ind, C] = kmeans([X Y], k);
    
%updateCluster(data);
for n = 1:length(hRB)-1
    hPlotObj.Cluster(n).Point.XData = [];
    hPlotObj.Cluster(n).Point.YData = [];
end

for n = 1:k
    xc = X(ind==n);
    yc = Y(ind==n);
%     hPlotObj.ClusterPoint(n).XData = xc;
%     hPlotObj.ClusterPoint(n).YData = yc;
    
    kb = boundary(xc, yc);
    hPlotObj.ClusterBoundary(n).XData = xc(kb);
    hPlotObj.ClusterBoundary(n).YData = yc(kb);
end

guidata(hFig, data);