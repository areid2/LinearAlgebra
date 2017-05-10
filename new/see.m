function [] = see(v, res)
    imagesc(reshape(v,[res, res]));
    colormap(gray);
end
