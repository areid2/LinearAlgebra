function B = tmul(A,M,n)
    K = shiftdim(A,n-1);
    B = shiftdim(reshape(M*K(:,:),[size(M,1),size(K,2),size(K,3)]),4-n);
end