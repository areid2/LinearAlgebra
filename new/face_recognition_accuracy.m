clear; close; clc;

%load variables from ryale_gen
res = 64;
load(['ryale', int2str(res), '.mat']);
tic;

%image vector length, pictures per person, number of people
a=zeros(res^2,e,15);
for i=1:15
    for j=1:e
        a(:,j,i)=rfea((i-1)*e+j,:);
    end
end

%preprocessing
[s,f,g,h]=thinHOSVD(a);
c = tmul(s,g,2);
q=zeros(150,15,e);
r=zeros(15,15,e);
for ie=1:e
    b=permute(c(:,ie,:),[1,3,2]);
    [q(:,:,ie),r(:,:,ie)]=qr(b,0);
end

%facial recognition
for p=1:50
    %random number for test picture
    rnum=randi(size(tgnd,1));

    %set test picture
    z=tfea(rnum,:)'; 

    %reset variables
    rsoln=-1;
    rexp=-1;
    m=Inf;
    
    %face recognition algorithm
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
    x(p)=(tgnd(rnum)==rsoln);
    % subplot(1,2,1), face64(z)
    % title('Randomly Picked Face')
    % pbaspect([1 1 1])
    % subplot(1,2,2), face64(a(:,rexp,rsoln))
    % title('Facial Recognition Software Returned Face')
    % pbaspect([1 1 1])
end
toc
accuracy=sum(x)/p
% for p=50, accuracy=84% time elapsed 8.243976s
% for p=100, accuracy=84% time elapsed 15.745067s
% for p=150, accuracy=82.67% time elapsed 24.249468s
% for p=200, accuracy=83% time elapsed 31.005748s
% Code consistently shows an accuracy of around 83%
% Not too fabulous