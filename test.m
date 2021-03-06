clear; close; clc;

%preprocessing
load('yale32.mat');

% there are 15 people with 11 faces. columns correspond to people, stacks
% are expressions
df = fea;
dg = gnd;
a = zeros(1024,11,15);
for i=1:15
    for j=1:11
        a(:,j,i)=df((i-1)*11+j,:);
    end
end
%Picking a face and removing it from the matrix
z=a(:,1,1);
a(:,1,1)=z-z;

%face recognition
[s, f, g, h] = thinHOSVD(a);
c = tmul(tmul(s,f,1),g,2);

%With Exact Face in Matrix Use this Loop
% for e = 1:11
%     t = permute(c(:,e,:),[1,3,2]);
%     ae = (t'*t)\t'*z;
%     for p=1:15
%         n = norm((ae-h(p,:)'),2);
%         if n < 0.1
%             disp(n)
%             disp(e)
%             disp(p)
%             disp_face(a(:,e,p))
%             pause(2)
%         end
%     end
% end

%Without exact Face Use this loop
for e = 1:11
    t = permute(c(:,e,:),[1,3,2]);
    ae = (t'*t)\t'*z;
    for p=1:15
        n = norm((ae-h(p,:)'),2);
        norm_list(e,p)=n;
    end
end
[M,I]=min(norm_list(:));
[e,p]=ind2sub(size(norm_list),I);
face=a(:,e,p);
figure
disp_face(z)
figure
disp_face(face)
