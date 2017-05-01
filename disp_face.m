function [] = disp_face(v)
    Y = zeros(32*1,32*1); 
    Y(0*32+1:(0+1)*32,0*32+1:(0+1)*32) = reshape(v,[32,32]); 
    imagesc(Y);colormap(gray);
end
 %seeing if this works just as well
