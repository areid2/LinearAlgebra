clear; close; clc;

%load variables from ryale_gen
load('ryale64.mat');

%random number for test picture
r=randi(size(tgnd,1));

%image vector length, pictures per person, number of people
a=zeros(4096,e,15);
for i=1:15
    for j=1:e
        a(:,j,i)=rfea((i-1)*e+j,:);
    end
end

%set test picture
z=tfea(r,:)'; 

%face recognition algorithm
[s,f,g,h]=thinHOSVD(a);
c = tmul(tmul(s,f,1),g,2);
rsoln=-1;
rexp=-1;
m=Inf;
for ie=1:e
    t=permute(c(:,ie,:),[1,3,2]);
    ae=(t'*t)\t'*z;
    for ip=1:15
        if norm((ae-h(ip,:)'),2)<m
            m=norm((ae-h(ip,:)'),2);
            rsoln=ip;
            rexp=ie;
        end
    end
end

%answer
disp(tgnd(r)==rsoln);
figure
face64(z);
figure
face64(a(:,rexp,rsoln));