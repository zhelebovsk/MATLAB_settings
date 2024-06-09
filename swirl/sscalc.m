function [cvi,ssi] = sscalc(X,Y,u,v,dx,np)
    ymin = Y(1,1);
    ymax = Y(end,1);
    xmin = X(1,1);
    xmax = X(1,end);
    
    [x,y] = meshgrid(xmin:dx:xmax,ymin:dx:ymax);
  
    % using regular gradient, no smoothing
%     [Ux,Uy] = gradient(u,dx);
%     [Vx,Vy] = gradient(v,dx);
%     d = (Ux+Vy).^2 - 4*(Ux.*Vy - Uy.*Vx);
%     d(d>0) = 0;
%     ssi = sqrt(abs(d))/2;
%     cvi = Vx - Uy;
%     subplot(1,2,1);
%     h1 = pcolor(X,Y,double(ssi));
%     set(h1,'edgecolor','none');
%     colorbar
%     axis image
    
    
    % using Savitsky Golay algorithm
    r = np;
    kernel = sgsdf_2d(-r:r,-r:r,2,2,0,0);
    differentiatorx = sgsdf_2d(-r:r,-r:r,2,2,1,0);
    differentiatory = sgsdf_2d(-r:r,-r:r,2,2,1,0)';
    ui = convolve2(u,(kernel),'reflect');
    vi = convolve2(v,(kernel),'reflect');
    Ux = convolve2(u,(differentiatorx),'reflect')/dx;
    Vx = convolve2(v,(differentiatorx),'reflect')/dx;
    Uy = convolve2(u,(differentiatory),'reflect')/dx;
    Vy = convolve2(v,(differentiatory),'reflect')/dx;
    d = (Ux+Vy).^2 - 4*(Ux.*Vy - Uy.*Vx);
    d(d>0) = 0;
    ssi = sqrt(abs(d))/2;
    cvi = -(Vx - Uy);
%     subplot(1,2,2);
%     h1 = pcolor(X,Y,double(ssi));
%     set(h1,'edgecolor','none');
%     colorbar
%     axis image
    

end