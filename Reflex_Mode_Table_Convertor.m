ModeTable=readtable('Mode_Table.xlsx');
ColumnName=ModeTable.Properties.VariableNames;

idx1=strcmp(ModeTable.ModeNumber,"ShapeData");
row1=find(idx1);
idx2=strcmp(ModeTable.ModeNumber,"DOF");
row2=find(idx2);
idx3=strcmp(ModeTable.ModeNumber,"");
row3=find(idx3);

Modes=str2double(ModeTable.ModeNumber(row1-1)); % Modes number
NF=str2double(ModeTable.UndampedFrequency(row1-1)); % Hz
DOF=ModeTable.ModeNumber(row2(1)+1:row3(1)-1); % DOFs. string.
EigenVector=zeros(length(DOF),length(Modes)); 
DampingRatio=str2double(ModeTable.DampingPercent(row1-1)); % percent
for k=1:length(Modes)
    EigenVector(:,k)=str2double(ModeTable.UndampedFrequency(row2(k)+1:row2(k)+length(DOF)));
end