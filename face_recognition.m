clear; close; clc;

%preprocessing
load('yale32.mat');

%dimensions
l = 32;
w = 32;
e = 11;
p = 15;

%image vector length, pictures per person, number of people
a = zeros(l*w,e,p);
for i=1:p
    for j=1:e
        a(:,j,i)=fea((i-1)*e+j,:);
    end
end

%test picture
z=a(:,7,8);

%bottleneck
[s, f, g, h] = thinHOSVD(a);

%face recognition
c = tmul(tmul(s,f,1),g,2);
soln = -1;

for ee = 1:e
    t = permute(c(:,ee,:),[1,3,2]);
    ae = (t'*t)\t'*z;
    for pp=1:p
        if norm((ae-h(pp,:)'),2) < 0.001
            soln = pp;
        end
    end
end

%answer
disp(soln);