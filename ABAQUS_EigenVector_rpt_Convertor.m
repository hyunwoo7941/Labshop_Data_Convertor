close all; clear all; clc;
ABAQUS_ModeTable=readtable('260213_abaqus_modal_eigenvector.rpt', 'FileType', 'text');
% Eigenvector 를 뽑을 때 U1 U2 U3 방향으로 뽑은 rpt 파일에 적용 가능
% 만일 다른 방향을 추가하거나 제외하고 뽑았다면 그에 맞게 코드를 수정해야만 함.

idx0=strcmp(ABAQUS_ModeTable.Var5,'State'); 
row0=find(idx0);
% 가끔 중복되어 나오는 경우 있는데, State 를 기준으로 새로생성되기 때문에
% 이를 바탕으로 실제 모드 개수를 판별해줄 필요가 있음.

idx1=strcmp(ABAQUS_ModeTable.Var7,"Freq"); % 고유진동수 찾기
row1=find(idx1);
NF=ABAQUS_ModeTable.Var9(row1);

Modes=[1:length(NF)/(length(row0)+1)]';

idx2=~isnan(ABAQUS_ModeTable.Var1);
row2=find(idx2);
idx3=isnan(ABAQUS_ModeTable.Var1);
row3=find(idx3);
DOF=[row2(1):row3(1)-1]'; % 여기서의 DOF 는 노드 넘버임.
n=length(DOF);
for k=1:length(Modes)
    temp=[ABAQUS_ModeTable.Var2(row2(k*n+1):row2((k+1)*n)) ...
        ABAQUS_ModeTable.Var3(row2(k*n+1):row2((k+1)*n)) ...
        ABAQUS_ModeTable.Var4(row2(k*n+1):row2((k+1)*n)) ];
    EigenVector(:,k)=reshape(temp.',[],1);
end
% 결과가 행은 노드 번호, 열은 U1 U2 U3 자유도 방향 값이 나오게 된다.
% 이것을 x1 y1 z1 x2 y2 z2 ... 식으로 행을 정렬하고, 열은 mode number 에 맞게 정렬해준 코드이다.
ABAQUS_ModalResult.Modes=Modes;
ABAQUS_ModalResult.NF=NF;
ABAQUS_ModalResult.DOF=DOF;
ABAQUS_ModalResult.EigenVector=EigenVector;
save('ABAQUS_ModalResult.mat');
