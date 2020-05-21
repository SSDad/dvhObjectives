function gui_ObjectiveAnalysis

%% main window

hFig = figure('MenuBar',            'none', ...
                    'Toolbar',              'none', ...
                    'HandleVisibility',  'callback', ...
                    'Name',                'Objective Analysis', ...
                    'NumberTitle',      'off', ...
                    'Units',                 'normalized',...
                    'Position',             [0.1 0.1 0.8 0.8],...
                    'Color',                 'black', ...
                    'Visible',               'on');

%% menu
% [hToolbar] = addToolbar(hFig_main);
% data_main.hToolbar = hToolbar;
% 
% [hMenu, hMenuItem] = addMenu(hFig_main);
% data_main.hMenu = hMenu;
% data_main.hMenuItem = hMenuItem;

%% panel, table
data.Panel = addPanel(hFig);
data.Panel.LoadData.Comp = addComponents2Panel_LoadData(data.Panel.LoadData.hPanel);

guidata(hFig, data);
               
% data_main.hPanel = hPanel;
% data_main.hSliderX = hSliderX;
% data_main.hSliderY = hSliderY;
% data_main.hSliderZ = hSliderZ;
% data_main.hAxis = hAxis;
% data_main.hPlotObj = hPlotObj;
% data_main.hText = hText;
% 
% data_main.alpha = 1;
% 
% data_main.x = 0;
% data_main.y = 0;
% data_main.z = 0;
% 
% data_main.CTImagesLoaded = false;
% data_main.TPSDoseLoaded = false;
% data_main.G4DoseLoaded = false;
% data_main.GammaMap = false;
% 
% data_main.profFigOpen = false;
% data_main.ProfileFig = false;
% 
% %% save
% guidata(hFig_main, data_main);
               