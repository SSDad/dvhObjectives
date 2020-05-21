function displayInfo(src, evnt, hCrosshair, T)

pos = evnt.CurrentPosition;
Vol = T.Property;
if strcmp(computer, 'PCWIN64')
    Vol = str2double(Vol);
end

Dose = T.Value;

d2 = (pos(1)-Dose).^2+(pos(2)-Vol).^2;
[val, idx] = min(d2);

PtID = [];
if val < 1
    xp = Dose(idx);
    yp = Vol(idx);
    hCrosshair.Text.Position = [xp+1 yp+2];
    hCrosshair.Text.String = [num2str(T.PatientID(idx)), ' - ', T.StructureId{idx}];
    
    hCrosshair.Point.XData = xp;
    hCrosshair.Point.YData = yp;
end

