function map = greyMap
% Greyscale custom colormap
    x = linspace(0, 1, 256);
    bell = 0.25*sin(x*pi);
    shift = 32;
    r = sin((x+x(shift))*2*pi).*bell;
    b = sin((x-x(shift))*2*pi).*bell;
    g = (-r - b).*bell ;
    map = [r' g' b' ] + x';
end