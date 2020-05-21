function Callback_Radiobutton_ObjectivePanel(src, evnt)

hFig = ancestor(src, 'Figure');
data = guidata(hFig);

objName = data.Mtc.uniqMetric;
sObjName = evnt.Source.String;
iMetric =  find(strcmp(sObjName, objName));
data.iMetric = iMetric;

hRB = data.Panel.Objective.Comp.RB.hRB;
for n = 1:length(hRB)
    if n~=iMetric+1
        hRB(n).Value = 0;
    end
end

data.Panel.Structure.Comp.RB = [];
data.Panel.Structure.Comp.RB = addComponents2Panel_Structure(data.Panel.Structure.hPanel, data.Mtc.Metric(iMetric));
CLR = data.Panel.Structure.Comp.RB.CLR;

data.Panel.View.Comp = initPanel_View(data.Panel.View, CLR, length(data.Mtc.Metric(iMetric).uniqStruct));
% set (hFig, 'WindowButtonMotionFcn', @mouseMove);

updateView(data);

hAxis = data.Panel.View.Comp.hAxis;
Crosshair = data.Panel.View.Comp.hPlotObj.Crosshair;
xm = mean(hAxis.XLim);
ym = mean(hAxis.YLim);
Crosshair.roi.Position = [xm ym];
% addlistener(hCrosshair, 'ROIMoved', @displayInfo);
Crosshair.roiListener = addlistener(Crosshair.roi, 'ROIMoved', @(src, evnt)displayInfo(src, evnt,...
    data.Panel.View.Comp.hPlotObj.Crosshair, data.Mtc.Metric(iMetric).T));

data.Panel.Structure.hPanel.Visible = 'on';
data.Panel.View.hPanel.Visible = 'on';

guidata(hFig, data);