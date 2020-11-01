%x and y are the position corrdinates of the photon
%Here object is H

function[T,gema]=objct(x,y)

    Transmsvty=0.98; %transmissivity of the object(for the hole)
    gema=0.3*pi; % phase shift due to the object
    
    in_out=0; % initial value of dummy variable is zero
    in_out=in_out+lettrH(x,y); % value will increase if the point is in the letter H
    in_out=in_out+lettrU(x,y); % value will increase if the point is in the letter H
    
    if in_out==1 % if the point is in either letter
        T= Transmsvty; 
    else
        T=0;
    end
end
