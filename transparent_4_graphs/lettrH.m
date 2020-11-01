%x and y are the position corrdinates of the photon
%Here the letter is H.
%if the xy point is in the letter this function will return the value 1. 
%if not this will return 0

function [in_out]=lettrH(x,y)

    size=0.38; % size of the letter (width=height=2*size )
    center=[-0.45,0];% (x,y) coordinate represent the location of the letter
    
    x=x-center(1);
    y=y-center(2);
    
    if (abs(x)<=size)&&(abs(y)<=size)&&( (abs(x)>=0.33*size) || (abs(y)<=0.33*size) ) % within the size AND (two verticle lines OR horizontal line)
        in_out=1;
    else
        in_out=0;
    end    
end
