clc
clear
close


photns=50000; %number of photons generted in the experiment(this will reduce by the gaussian shape)
alpha=0.4; % detecting probability of the detector
width=0.5; % this will control the gussian shape of the incident beam


[X,Y] = meshgrid(-1:.01:1);
ZH=zeros(201);
ZG=zeros(201);

for i=1:photns
    
        x=(randn)*width; % genarate random number (define the x position randomly)
        y=(randn)*width; % genarate random number (define the y position randomly)
        
            
        [T,gema]= objct(x,y); % according to function object, T will equal to the value of the transmissivity only if the point is in a letter
                                    % if not T=0. gema will get the value defined in the function object.
            
        ProbH=0.5*(1+T*cos(gema)); % calculate the probability of photon to go to H detector as the equation(Zelinger)
        ProbG=0.5*(1-T*cos(gema)); % calculate the probability of photon to go to G detector as the equation(Zelinger)
        
        x=round(x,2)*100; % this will round the x position to a number between -100 and 100
        y=round(y,2)*100; % this will round the y position to a number between -100 and 100
        
        x=int16(x+size(X,1)/2.000001); %shift the number to (0, 200) and convet that in to an integer. ( /2 make a line could not identify) 
        y=int16(y+size(X,1)/2.000001); %shift the number to (0, 200) and convet that in to an integer. ( /2 make a line could not identify

        if x<=201 && y<=201 && x>=1 && y>=1 %check the range of x and y with the diamention of meshgrid
            choice=rand;   %this photon can be detect by either G detector or H detector according to their probabilities
            if choice<ProbH % theoritically it is more probable to detect it by H detector ( because ProbH >ProbG )
                ZH(x,y)=ZH(x,y)+1; % increase the number of detected photon at the pixel (x,y)at H detector
            else
                ZG(x,y)=ZG(x,y)+1; % increase the number of detected photon at the pixel (x,y)at G detector
            end
        end    
end

Zsum=ZG+ZH; % calculate the sum of G and H detectors
Zdif=ZH-ZG; % calculate the differance of G and H detectors(this may have negative values. but most of them are positive numbers)

colormap jet; %define the color map
subplot(2,2,1);
pcolor(Y,X,ZH); shading flat; %plot and way of shading
colorbar % show color bar
subplot(2,2,2);
pcolor(Y,X,ZG); shading flat;
colorbar
subplot(2,2,3);
pcolor(Y,X,Zsum); shading flat;
colorbar
subplot(2,2,4);
pcolor(Y,X,Zdif); shading flat;
colorbar

set(gcf, 'Position', [150 150 600 400]);
export_fig transparent_HU_11figure.png -transparent -r1000;

