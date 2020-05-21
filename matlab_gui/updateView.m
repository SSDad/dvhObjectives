function updateView(data)

RB = data.Panel.Structure.Comp.RB;
hRB = RB.hRB;
hPlotObj = data.Panel.View.Comp.hPlotObj;

iMetric = data.iMetric;

for n = 2:length(hRB)
    if hRB(n).Value
        hPlotObj.xy(n-1).XData = data.Mtc.Metric(iMetric).Struct(n-1).Dose;
        hPlotObj.xy(n-1).YData = data.Mtc.Metric(iMetric).Struct(n-1).Vol;
    else
        hPlotObj.xy(n-1).XData = [];
        hPlotObj.xy(n-1).YData = [];
    end
    
    hPlotObj.ClusterBoundary(n-1).XData = [];
    hPlotObj.ClusterBoundary(n-1).YData = [];
end