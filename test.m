clear; close; clc;

%preprocessing
dd = importdata('yale32.mat');

% there are 15 people with 11 faces. columns correspond to people, stacks
% are expressions
df = dd.fea;
dg = dd.gnd;
a = zeros(1024,11,15);
for i=1:15
    for j=1:11
        a(:,j,i)=df((i-1)*j+j,:);
    end
end
z=a(:,7,8);

%face recognition
[s, f, g, h] = thinHOSVD(a);
c = tmul(tmul(s,f,1),g,2);
norm_list=[];
for e = 1:11
    t = permute(c(:,e,:),[1,3,2]);
    ae = (t'*t)\t'*z;
    for p=1:15
        norm((ae-h(p,:)),2)
    end
end