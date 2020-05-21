function Callback_Radiobutton_StructurePanel(src, evnt)

hFig = ancestor(src, 'Figure');
data = guidata(hFig);

hRB = data.Panel.Structure.Comp.RB.hRB;
if strcmp(src.String, 'Structures')
    for n = 2:length(hRB)
        data.Panel.Structure.Comp.RB.hRB(n).Value = hRB(1).Value;
    end
end

for n = 2:length(hRB)
    if data.Panel.Structure.Comp.RB.hRB(n).Value
        if exist('T', 'var')
            T = [T; data.Mtc.Metric(data.iMetric).Struct(n-1).T];
        else
            T = data.Mtc.Metric(data.iMetric).Struct(n-1).T;
        end
    end
end    
updateView(data)

hCrosshair = data.Panel.View.Comp.hPlotObj.Crosshair;
hCrosshair.Text.String = [];

hCrosshair.Point.XData = [];
hCrosshair.Point.YData = [];

if exist('T', 'var')
    hCrosshair.roiListener.Callback = @(src, evnt)displayInfo(src, evnt,...
    data.Panel.View.Comp.hPlotObj.Crosshair, T);    
end

guidata(hFig, data);