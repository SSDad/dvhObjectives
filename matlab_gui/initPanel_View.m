function [Comp] = initPanel_View(View, CLR, nStruct)

MK = 'ox+dsphv^ox+dsphv^';
MKSZ = ones(nStruct, 1)*8;

MK(1:7) = '.';
MK(8:end) = '^';
MKSZ(1:7) = 24;
MKSZ(8:end) = 6;

if ~isfield(View, 'Comp')
    hAxis = axes('Parent',                  View.hPanel, ...
                                'color',        'none',...
                                'xcolor', 'w',...
                                'ycolor', 'w', ...
                                'gridcolor',   'w',...
                                'Units',                    'normalized', ...
                                'HandleVisibility',     'callback', ...
                                'Position',                 [0.05 0.05 0.9 0.9]);

    hold(hAxis, 'on')
    
else
    hAxis = View.Comp.hAxis;
%     View.Comp.hPlotObj = [];
    delete(View.Comp.hPlotObj.xy);
    delete(View.Comp.hPlotObj.ClusterBoundary);
    delete(View.Comp.hPlotObj.Crosshair.roi);
    delete(View.Comp.hPlotObj.Crosshair.Point);
    delete(View.Comp.hPlotObj.Crosshair.Text);
end
Comp.hAxis = hAxis;

for iS = 1:nStruct    
    hPlotObj.xy(iS) = line(hAxis, 'XData', [], 'YData', [], 'LineStyle', 'none',...
        'Marker', MK(iS),  'MarkerSize', MKSZ(iS), 'MarkerFaceColor', CLR(iS+1, :),...
        'Color', CLR(iS+1, :), 'LineWidth', 2);

    hPlotObj.ClusterBoundary(iS) = line(hAxis, 'XData', [], 'YData', [], 'LineStyle', '-',...
        'Color', CLR(iS+1, :), 'LineWidth', 2);
end

hPlotObj.Crosshair.Point = line(hAxis, 'XData', [], 'YData', [], 'LineStyle', 'none',...
        'Marker', 'o',  'MarkerSize', 16, 'Color', 'c', 'LineWidth', 1);
hPlotObj.Crosshair.Text = text(hAxis, 'Color', 'w', 'FontSize', 14);
hPlotObj.Crosshair.roi = images.roi.Crosshair(hAxis, 'Color', 'c', 'LineWidth', .75, 'Deletable', 0);
Comp.hPlotObj = hPlotObj;

