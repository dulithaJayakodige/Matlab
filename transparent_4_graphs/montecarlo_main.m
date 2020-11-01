clc
clear
close


photns=5000000; %number of photons generted in the experiment(this will reduce by the gaussian shape)
alpha=0.9; % detecting probability of the detector
width=0.8; % this will control the gussian shape of the incident beam


[X,Y] = meshgrid(-1:.01:1);
ZGG=zeros(201);
ZHH=zeros(201);

for i=1:photns
    
        x=(randn)*width; % genarate random number (define the x position randomly)
        y=(randn)*width; % genarate random number (define the y position randomly)
        
            
        [T,gema]= objct(x,y); % according to function object, T will equal to the value of the transmissivity only if the point is in a letter
                                    % if not T=0. gema will get the value defined in the function object.
            
        ProbG=0.5*(1+T*cos(gema)); % calculate the probability of photon to go to H detector as the equation(Zelinger)
        ProbH=0.5*(1-T*cos(gema)); % calculate the probability of photon to go to G detector as the equation(Zelinger)
        
        x=round(x,2)*100; % this will round the x position to a number between -100 and 100
        y=round(y,2)*100; % this will round the y position to a number between -100 and 100
        
        x=int16(x+size(X,1)/2.000001); %shift the number to (0, 200) and convet that in to an integer. ( /2 make a line could not identify) 
        y=int16(y+size(X,1)/2.000001); %shift the number to (0, 200) and convet that in to an integer. ( /2 make a line could not identify

        if x<=201 && y<=201 && x>=1 && y>=1 %check the range of x and y with the diamention of meshgrid
            choice=rand;   %this photon can be detect by either G detector or H detector according to their probabilities
            if choice<ProbG % theoritically it is more probable to detect it by H detector ( because ProbH >ProbG )
                ZGG(x,y)=ZGG(x,y)+1; % increase the number of detected photon at the pixel (x,y)at H detector
            else
                ZHH(x,y)=ZHH(x,y)+1; % increase the number of detected photon at the pixel (x,y)at G detector
            end
        end    
end

Zsum=ZHH+ZGG; % calculate the sum of G and H detectors
Zdif=ZGG-ZHH; % calculate the differance of G and H detectors(this may have negative values. but most of them are positive numbers)

figure;
colormap jet; %define the color map
pcolor(Y,X,ZGG); shading flat; %plot and way of shading
colorbar % show color bar
set(gcf, 'Position', [0 0 165 100]);
export_fig transparent_HU_GG.png -transparent -r1000;

figure;
colormap jet; %define the color map
pcolor(Y,X,ZHH); shading flat;
colorbar
set(gcf, 'Position', [0 0 165 100]);
export_fig transparent_HU_HH.png -transparent -r1000;

figure;
colormap jet; %define the color map
pcolor(Y,X,Zsum); shading flat;
colorbar
set(gcf, 'Position', [150 150 165 100]);
export_fig transparent_HU_SUM.png -transparent -r1000;

figure;
colormap jet; %define the color map
pcolor(Y,X,Zdif); shading flat;
colorbar
set(gcf, 'Position', [0 0 165 100]);
export_fig transparent_HU_diff.png -transparent -r1000;


