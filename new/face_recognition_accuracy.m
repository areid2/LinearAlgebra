clear; close; clc;

%load variables from ryale_gen
res = 32;
load(['ryale', int2str(res), '.mat']);
tic;

for p=1:50
    %random number for test picture
    r=randi(size(tgnd,1));

    %image vector length, pictures per person, number of people
    a=zeros(res^2,e,15);
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
    x(p)=(tgnd(r)==rsoln);
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