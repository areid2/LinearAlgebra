function [s, u1, u2, u3] = thinHOSVD(A)
    [u1,~,~]=svd(unfold(A,1),'econ');
    [u2,~,~]=svd(unfold(A,2),'econ');
    [u3,~,~]=svd(unfold(A,3),'econ');
    s=tmul(tmul(tmul(A,u1',1),u2',2),u3',3);
end