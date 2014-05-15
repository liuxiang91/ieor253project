% demand mean and sd
d_mean=20;
sd=4;

% initialize array
A=zeros(11,23);
A(2:3,2:11)=ones(2,10);
A(2:3,13:22)=ones(2,10);
A(5:6,2:11)=ones(2,10);
A(5:6,13:22)=ones(2,10);
A(8:9,2:11)=ones(2,10);
A(8:9,13:22)=ones(2,10);

D=zeros(11,23);
D(2:3,2:11)=d_mean+sd*randn(2,10);
D(2:3,13:22)=d_mean+sd*randn(2,10);
D(5:6,2:11)=d_mean+sd*randn(2,10);
D(5:6,13:22)=d_mean+sd*randn(2,10);
D(8:9,2:11)=d_mean+sd*randn(2,10);
D(8:9,13:22)=d_mean+sd*randn(2,10);
D=max(zeros(11,23),D);

S=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;0,21,20,19,18,17,16,15,14,13,10,0,10,13,14,15,16,17,18,19,20,21,0;0,18,17,16,15,14,13,12,11,10,9,0,9,10,11,12,13,14,15,16,17,18,0;0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;0,18,17,16,15,14,13,12,11,10,7,0,7,10,11,12,13,14,15,16,17,18,0;0,15,14,13,12,11,10,9,8,7,6,0,6,7,8,9,10,11,12,13,14,15,0;0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;0,15,14,13,12,11,10,9,8,7,4,0,4,7,8,9,10,11,12,13,14,15,0;0,12,11,10,9,8,7,6,5,4,3,0,3,4,5,6,7,8,9,10,11,12,0;0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];

% stores id of each node
count=1;
node_id_table=zeros(120,3);
for y=1:11
    for x =1:23
        if A(y,x)~=0
            node_id_table(count,:)=[count x y];
            count=count+1;
        end
    end
end

% randomly pick 20 points and store demand
index=randperm(120);
index=index(1:20);
demandXY=zeros(20,3); % demand x y (start from 1)
demandXY(:,1)=1:20;
demandXY(:,2)=key2code(node_id_table(index,2),node_id_table(index,3));
for i=1:20
    [x, y]=code2key(demandXY(i,2));
    demandXY(i,3)=D(y,x);
end

% Look up Lij
Lij=csvread('./Lij.csv');
Lij_code=zeros(400,3);
count=1;
for i=1:length(Lij)
    if  any(abs(key2code(Lij(i,1)+1,Lij(i,2)+1)-demandXY(:,2))<1e-10)
        if any(abs(key2code(Lij(i,3)+1,Lij(i,4)+1)-demandXY(:,2))<1e-10)
            Lij_code(count,:)=[key2code(Lij(i,1)+1,Lij(i,2)+1),key2code(Lij(i,3)+1,Lij(i,4)+1),Lij(i,5)];
            count=count+1;
        end
    end
end

for i=1:length(Lij_code)
    Lij_code(i,1)=demandXY(demandXY(:,2)==Lij_code(i,1));
    Lij_code(i,2)=demandXY(demandXY(:,2)==Lij_code(i,2));
end

% look up S
Si=zeros(20,2);
for i=1:length(demandXY)
    [x,y]=code2key(demandXY(i,2));
    Si(i,:)=[i S(y,x)];
end



