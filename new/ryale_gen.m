clear; close; clc;

%load yale face database
load('yale64.mat');

%expressions to reduce to
e=10;

%reduced vars, test vars
rfea=zeros(e*15, 4096);
rgnd=zeros(e*15, 1);
tfea=zeros((11-e)*15, 4096);
tgnd=zeros((11-e)*15, 1);

%reduced generation
k=1;
for i=1:15
    for j=1:e
        rfea(k,:)=fea((i-1)*11+j,:);
        rgnd(k)=i;
        k=k+1;
    end
end

%test generation
k=1;
for i=1:15
    for j=(e+1):11
        tfea(k,:)=fea((i-1)*11+j,:);
        tgnd(k)=i;
        k=k+1;
    end
end

%save variables to ryale32.mat
save('ryale64.mat', 'e', 'fea', 'gnd', 'rfea', 'rgnd', 'tfea', 'tgnd');