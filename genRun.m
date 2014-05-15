r='';
for i =1:100
    r=[r 'reset;\n'];
r=[r 'option solver cplex;\n'];
r=[r 'model main.mod;\n'];
r=[r 'data main' num2str(i) '.dat;\n'];
r=[r 'solve;\n'];
r=[r 'csvdisplay x > "./x' num2str(i) '.csv";\n'];
r=[r 'csvdisplay w > "./w' num2str(i) '.csv";\n'];
r=[r 'csvdisplay y > "./y' num2str(i) '.csv";\n'];
r=[r 'csvdisplay z > "./z' num2str(i) '.csv";\n'];
r=[r '\n'];
end
fileID = fopen(['main.run'] ,'w');
fprintf(fileID,r);
fclose(fileID);