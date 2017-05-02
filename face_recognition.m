clear; close; clc;

%preprocessing
load('yale32.mat');
load('reduced_yale32.mat');

%attributes
l = 32;
w = 32;
e = 9;
p = 15;

%image vector length, pictures per person, number of people
a = zeros(l*w,e,p);
for i=1:p
    for j=1:e
        a(:,j,i)=new_fea((i-1)*e+j,:);
    end
end

%set test picture
z=test_fea(5,:)'; 
old_soln = test_gnd(5);

%bottleneck
[s, f, g, h] = thinHOSVD(a);

%face recognition
c = tmul(tmul(s,f,1),g,2);
new_soln = -1;

%face recognition algorithm
m = Inf;
for ee = 1:e
    t = permute(c(:,ee,:),[1,3,2]);
    ae = (t'*t)\t'*z;
    for pp=1:p
        if norm((ae-h(pp,:)'),2) < m
            m = norm((ae-h(pp,:)'),2);
            new_soln = pp;
        end
    end
end

%answer
disp(old_soln==new_soln);