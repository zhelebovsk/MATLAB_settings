function h = plotCustom(varargin)
h = plot(varargin{:});
set(get(gca,'ylabel'),'rotation',0);
axis square
end
