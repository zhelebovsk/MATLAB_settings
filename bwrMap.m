function map = bwrMap
% Blue White Red linear custom colormap
    r = [linspace(0.1, 1, 127) linspace(1, 0.75, 128)]';
    g = [linspace(0.15, 1, 127) linspace(1, 0.15, 128)]';
    b = flip(r);    
    map = [r g b];
end