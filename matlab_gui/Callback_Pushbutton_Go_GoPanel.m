function Callback_Pushbutton_Go_GoPanel(src, evnt)

hFig = ancestor(src, 'Figure');
data = guidata(hFig);
hPanel = data.hPanel;

RB = data.Panel_Structure.RB;
hRB = RB.hRB;
CLR = RB.CLR;
hPlotObj = data.Panel_View.h.hPlotObj;

iStruct = data.iStruct;
Struct = data.obj.Struct{4};
xx = data.obj.xx{iStruct};
yy = data.obj.yy{iStruct};

for n = 2:length(hRB)
    if hRB(n).Value
        hPlotObj(n-1).XData = xx{n-1};
        hPlotObj(n-1).YData = yy{n-1};
    else
        hPlotObj(n-1).XData = [];
        hPlotObj(n-1).YData = [];
    end
end       

%guidata(hFig, data);