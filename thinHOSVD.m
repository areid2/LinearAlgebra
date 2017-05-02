function [S, U1, U2, U3] = thinHOSVD(A)
    [U1,~,~] = svd(unfold(A,1),'econ');
    [U2,~,~] = svd(unfold(A,2),'econ');
    [U3,~,~] = svd(unfold(A,3),'econ');
    S = tmul(tmul(tmul(A,U1',1),U2',2),U3',3);
end