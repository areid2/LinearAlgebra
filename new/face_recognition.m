clear; close; clc;

%load variables from ryale_gen
res = 32;
load(['ryale', int2str(res), '.mat']);

%random number for test picture
rnum=randi(size(tgnd,1));

%image vector length, pictures per person, number of people
a=zeros(res^2,e,15);
for i=1:15
    for j=1:e
        a(:,j,i)=rfea((i-1)*e+j,:);
    end
end

%set test picture
z=tfea(rnum,:)'; 

%face recognition algorithm

%preprocessing
[s,f,g,h]=thinHOSVD(a);
c = tmul(s,g,2);
rsoln=-1;
rexp=-1;
m=Inf;
q=zeros(150,15,e);
r=zeros(15,15,e);
for ie=1:e
    b=permute(c(:,ie,:),[1,3,2]);
    [q(:,:,ie),r(:,:,ie)]=qr(b,0);
end

for ie=1:e
    ae=r(:,:,ie)\(q(:,:,ie)'*f'*z);
    for ip=1:15
        tnorm = norm((ae-h(ip,:)'),2);
        if tnorm<m
            m=tnorm;
            rsoln=ip;
            rexp=ie;
        end
    end
end

%answer
disp(tgnd(rnum)==rsoln);
subplot(1,2,1), see(z, res)
title('Randomly Picked Face')
pbaspect([1 1 1])
subplot(1,2,2), see(a(:,rexp,rsoln), res)
title('Facial Recognition Software Returned Face')
pbaspect([1 1 1])