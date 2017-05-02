function [B] = unfold(A,n)
    if n == 1
        B=reshape(permute(A,[1,2,3]),size(A,1),size(A,2)*size(A,3));
    elseif n == 2
        B=reshape(permute(A,[2,1,3]),size(A,2),size(A,1)*size(A,3));
    elseif n == 3
        B=reshape(permute(A,[3,1,2]),size(A,3),size(A,1)*size(A,2));
    end
end