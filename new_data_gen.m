clear; close; clc;

load('yale32.mat');

new_fea = zeros(9*15, 1024);
new_gnd = zeros(9*15, 1);
test_fea = zeros(2*15, 1024);
test_gnd = zeros(2*15, 1);

k=1;
for i=1:15
    for j=1:9
        new_fea(k,:)=fea((i-1)*11+j,:);
        new_gnd(k) = i;
        k=k+1;
    end
end

k=1;
for i=1:15
    for j=10:11
        test_fea(k,:)=fea((i-1)*11+j,:);
        test_gnd(k) = i;
        k=k+1;
    end
end

save('reduced_yale32.mat', 'new_fea', 'new_gnd', 'test_fea', 'test_gnd');