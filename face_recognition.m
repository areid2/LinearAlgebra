clear; close; clc;

%preprocessing
load('yale32.mat');

%image vector length, pictures per person, number of people
a = zeros(1024,11,15);
for i=1:15
    for j=1:11
        a(:,j,i)=fea((i-1)*11+j,:);
    end
end

%test picture
z=a(:,7,8);

%bottleneck
[s, f, g, h] = thinHOSVD(a);

%face recognition
c = tmul(tmul(s,f,1),g,2);
soln = -1;

for e = 1:11
    t = permute(c(:,e,:),[1,3,2]);
    ae = (t'*t)\t'*z;
    for p=1:15
        if norm((ae-h(p,:)'),2) < 0.001
            soln = p;
        end
    end
end

%answer
disp(soln);