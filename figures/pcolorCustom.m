function h = pcolorCustom(varargin)
h = imagesc(varargin{:}, 'Interpolation','bilinear');
% set(gca, 'Position', [0.1 0.1 0.7 0.7], 'layer','top');
set(gca,"layer","top");

colorbar;
axis tight;
axis equal;
end
