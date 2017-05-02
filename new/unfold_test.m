%http://www.cs.cornell.edu/cv/SummerSchool/Unfold.pdf
clear; close; clc;

%generate 3D matrix to test
A = zeros(4,3,2);
A(:,:,1) = [111 121 131; 
            211 221 231;
            311 321 331;
            411 421 431];
A(:,:,2) = [112 122 132; 
            212 222 232;
            312 322 332;
            412 422 432];
        
%which dimension to unfold along
x = 1;

%display unfolding result
disp(unfold(A,x));