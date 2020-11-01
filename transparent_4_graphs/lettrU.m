%x and y are the position corrdinates of the photon
%Here the letter is H.
%if the xy point is in the letter this function will return the value 1. 
%if not this will return 0

function [in_out]=lettrU(x,y)

    size=0.38; % size of the letter (width=height=2*size )
    center=[0.45,0]; % (x,y) coordinate represent the location of the letter
    
    x=x-center(1);
    y=y-center(2);
    
    if (abs(x)<=size)&&(abs(y)<=size)  && ( (y>=0)&&(abs(x)>=0.33*size) || (y<0)&&(abs(x^2+y^2)>=0.1089*size^2)&&(abs(x^2+y^2)<=size^2)) % within the size AND( upper part OR lower part )
        in_out=1;
    else
        in_out=0;
    end
    
end
