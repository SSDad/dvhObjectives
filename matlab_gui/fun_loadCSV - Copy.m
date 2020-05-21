function [obj] = fun_loadCSV(ffn)

%% read csv
T = readtable(ffn);
ptID = table2array(T(:, 1));
courseID = table2cell(T(:, 2));
planID = table2cell(T(:, 3));
strctID = table2cell(T(:, 4));
Metric = table2cell(T(:, 5));
Property = str2double(table2cell(T(:, 6)));
Value = table2array(T(:, 7));
Param = table2array(T(:, 8));

%% Objectives
uniqMetric = unique(Metric);

for n = 1:length(uniqMetric) % objective
    ind = find(strcmp(Metric, uniqMetric{n}));
    pt = ptID(ind);
    strct = strctID(ind);
    y = Property(ind);
    x = Value(ind);
    
    strct = lower(erase(strct, '_'));
    uniqStrct{n} = unique(strct);
    nS = length(uniqStrct{n});
    
    for m = 1:nS % structure
        ind2 = find(strcmp(strct, uniqStrct{n}{m}));
        pt2{m} = pt(ind2);
%         strct2{n}{m} = strct(ind2);
        yy{n}{m} = y(ind2);
        xx{n}{m} = x(ind2);
        
        [uniqPT, indPT] = unique(pt2{m});
        for iP = 1:length(uniqPT)
            ind3 = find(pt2{m}==uniqPT(iP));
        end
        
    end
end

obj.Metric = uniqMetric;
obj.Struct = uniqStrct;
obj.xx = xx;
obj.yy = yy;
