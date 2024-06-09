function [] = ss_filter()
    clc

    folder='E:\merrillprocess\do_over\VectorFields\pos2\smooth'; 
    load([folder '/X.mat'],'X');
    load([folder '/Y.mat'],'Y');
    load([folder '/s.mat'],'s');
    load([folder '/d.mat'],'d');
    load([folder '/Um.mat'],'Um');
    Y  = Y(1:s,:);
    X  = X(1:s,:);
    y = Y(:,1);
    dx = abs(mode(diff(y)));
    u0 = max(mean(spin(Um(:,1:s)),2));

    fbase='run'; 
    runs = [0:1:9];
    frames = [1:1:1024];
    Nframes = numel(frames);
    
    
     
    % mean velocity field
    n = 4;
    load([folder '/' fbase,num2str(n) '/V.mat'],'V');
    load([folder '/' fbase,num2str(n) '/U.mat'],'U');
        
     f = 250;
     u = spin(U(:,1:s,f));
     v = spin(V(:,1:s,f));   
                    
     np = 3;
     [cv,ss] = sscalc(X,Y,u,v,dx,np);

end

function [x] = spin(x)
    x = rot90(x);       % to match DaVis display with flow R->L 
    x = fliplr(x);      % to make flow go L->R (also need to change sign of U)
end

function [cvi,ssi] = sscalc(X,Y,u,v,dx,np)
    ymin = Y(1,1);
    ymax = Y(end,1);
    xmin = X(1,1);
    xmax = X(1,end);
    
    [x,y] = meshgrid(xmin:dx:xmax,ymin:dx:ymax);
  
    % using regular gradient, no smoothing
    [Ux,Uy] = gradient(u,dx);
    [Vx,Vy] = gradient(v,dx);
    d = (Ux+Vy).^2 - 4*(Ux.*Vy - Uy.*Vx);
    d(d>0) = 0;
    ssi = sqrt(abs(d))/2;
    cvi = Vx - Uy;
%     subplot(1,2,1);
%     h1 = pcolor(X,Y,double(ssi));
%     set(h1,'edgecolor','none');
%     colorbar
%     axis image
    
    % using Savitsky Golay algorithm
    r = np;
    kernel = sgsdf_2d(-r:r,-r:r,2,2,0,0)
    differentiatorx = sgsdf_2d(-r:r,-r:r,2,2,1,0)
    differentiatory = sgsdf_2d(-r:r,-r:r,2,2,1,0)'
    ui = convolve2(u,kernel,'reflect');
    vi = convolve2(v,kernel,'reflect');
    Ux = convolve2(u,differentiatorx,'reflect');
    Vx = convolve2(v,differentiatorx,'reflect');
    Uy = convolve2(u,differentiatory,'reflect');
    Vy = convolve2(v,differentiatory,'reflect');
    d = (Ux+Vy).^2 - 4*(Ux.*Vy - Uy.*Vx);
    d(d>0) = 0;
    ssi = sqrt(abs(d))/2;
    cvi = Vx - Uy;
%     subplot(1,2,2);
%     h1 = pcolor(X,Y,double(ssi));
%     set(h1,'edgecolor','none');
%     colorbar
%     axis image
%     colormap(jet)
    

end
