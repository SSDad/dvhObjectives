function [data] = fun_getMetricFromCSV(ffn)

%% read csv
T = readtable(ffn);
T.StructureId = lower(erase(T.StructureId, '_'));

uniqMetric = unique(T.Metric); % Metric
for iM = 1:length(uniqMetric)
    Metric(iM).T = T(strcmp(T.Metric, uniqMetric{iM}), :);
    Metric(iM).uniqStruct = unique(Metric(iM).T.StructureId);
    for iS = 1:length(Metric(iM).uniqStruct)
        Metric(iM).Struct(iS).T = Metric(iM).T(strcmp(Metric(iM).T.StructureId, Metric(iM).uniqStruct{iS}), :);
        PtID = Metric(iM).Struct(iS).T.PatientID;
        [Metric(iM).Struct(iS).uniquePt, ~, ic] = unique(PtID);
        Metric(iM).Struct(iS).countPt = accumarray(ic, 1);
        
        Metric(iM).Struct(iS).Vol = Metric(iM).Struct(iS).T.Property;
        if strcmp(computer, 'PCWIN64')
            Metric(iM).Struct(iS).Vol = str2double(Metric(iM).Struct(iS).Vol);
        end
        
        Metric(iM).Struct(iS).Dose = Metric(iM).Struct(iS).T.Value;
        
%         for iP = 1:length(Metric(iM).Struct(iS).uniquePt)
%             Metric(iM).Struct(iS).Pt(iP).T = Metric(iM).Struct(iS).T(Metric(iM).Struct(iS).T.PatientID==Metric(iM).Struct(iS).uniquePt(iP), :);
%             Metric(iM).Struct(iS).Pt(iP).Vol = Metric(iM).Struct(iS).Pt(iP).T.Property;
%             Metric(iM).Struct(iS).Pt(iP).Dose = Metric(iM).Struct(iS).Pt(iP).T.Value;
%         end
    end
end

data.uniqMetric = uniqMetric;
data.Metric = Metric;