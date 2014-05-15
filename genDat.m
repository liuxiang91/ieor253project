function [  ] = genDat( Lij, D, S)
%GENDAT Summary of this function goes here
%   Detailed explanation goes here
str=['param D:=\n'];
for  i=1:20
    str=[str num2str(i) ' ' num2str(D(i,3)) '\n'];
end

str=[str ';\nparam S:=\n'];
for  i=1:20
    str=[str num2str(i) ' ' num2str(S(i,2)) '\n'];
end
str=[str ';\n'];
L=zeros(20,21);
for i=1:length(Lij)
    L(Lij(i,1),Lij(i,2)+1)=Lij(i,3);
end
L(:,1)=1:20;
str=[str 'param L:' num2str(1:20) ':=\n'];
s=num2str(L) ;
for i=1:20
    str=[str s(i,:) '\n'];
end
str=[str ';\n'];
str=[str 'param C =60;'];

fileID = fopen('main.dat','w');
fprintf(fileID,str);
fclose(fileID);