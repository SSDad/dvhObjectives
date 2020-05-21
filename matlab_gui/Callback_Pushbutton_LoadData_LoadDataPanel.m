function Callback_Pushbutton_LoadData_LoadDataPanel(src, evnt)

hFig = ancestor(src, 'Figure');
data = guidata(hFig);
hPanel = data.Panel.LoadData.hPanel;

%% load image data
% td = tempdir;
% fd_info = fullfile(td, 'dvObjective');
% fn_info = fullfile(fd_info, 'info.mat');
% if ~exist(fd_info, 'dir')
%     [matFile, dataPath] = uigetfile('*.mat');
%     mkdir(fd_info);
%     save(fn_info, 'dataPath');
% else
%     if ~exist(fn_info, 'file')
%         [matFile, dataPath] = uigetfile('*.mat');
%         save(fn_info, 'dataPath');
%     else
%         load(fn_info);
%         [matFile, ~] = uigetfile([dataPath, '*.mat']);
%     end
% end
% hWB = waitbar(0, 'Loading data...');
% data.dataPath = dataPath;
% data.matFile = matFile;
[csvFile, dataPath] = uigetfile('*.csv');
ffn = fullfile(dataPath, csvFile);

[data.Mtc] = fun_getMetricFromCSV(ffn);
% CLR = rand(100, 3);
% CLR(2:4, :) = eye(3);
% CLR(5:7, :) = 1-eye(3);
% CLR(8, :) = 1;
% data.obj.CLR = CLR;

data.Panel.Objective.Comp.RB.hRB = addComponents2Panel_Objective(data.Panel.Objective.hPanel, data.Mtc);

data.Panel.Objective.hPanel.Visible = 'on';

guidata(hFig, data);