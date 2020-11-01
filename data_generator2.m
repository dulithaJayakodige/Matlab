clc
clear
%% first part

x1=[5 10 15 20 25 30 32.5 35 40 45]*100; %The range of this will be range for generating data
y1=[2.3 2.8 2.3 1.2 0.1 0.5 4.5 1.2 0.3 0.3]; %generating data will follow these data points
inc = 0.1*100; % this will be the increment of generated data. (this contros # of data points which are generating)
senst=2e-2 ; % this parameter controals the the deviation of data form the referance graph

% we can change variables upto here. They are inputs. We have another set of inputs at the beginig of the second part

plot(x1,y1,'o'); % plot given data points to visualize the path
x=x1(1); y= y1(1); % initial values for x and y (start)
rang= range(y1); % biggest in y1 - smallest in y1
x2=[];y2=[]; % two empty matrices to fill genating data

for j=1:length(x1)-1 % firts data point and second data point, second data point and third data point,...

target= [x1(j+1) y1(j+1)]; % new data will generate towards this data pointwhich is the next given data point
bias= (target(2)-y)./(target(1)-x); % gradient between current point and target point

Num_points= (target(1)-x)/inc; %number of new points ging to generate inside this region

for i=1:Num_points
   
    x2 = [x2;x]; %save generated data in x2 matrix
    y2 = [y2;y]; %save generated data in y2 matrix
    x=x+inc; % increase the x value to a new value
    y=y + rang*senst*(randn) + bias*inc; % increment for y, fist part will add random number to present value according to the sensitivity(sensitivity depends on the range of y1 too) 
                                        % second part is biasing new point towards the target point.
    if y<0 % this willavoide negative values for y
        y=0;
    end
end


end

hold on 
plot(x2,y2)

 %% second part
clc
clearvars -except x2 y2
 
x1=x2; % out out of first part will be the inpout for second part
y1=y2;


% we can change followind two parameters
inc = 0.1*10; % this will be the increment of generated data. (this contros # of data points which are generating)
senst=1e-2 ; % this parameter controals the the deviation of data form the referance graph



x=x1(1); y= y1(1); % initial values for x and y (start)
rang= range(y1); % biggest in y1 - smallest in y1
x2=[];y2=[]; % two empty matrices to fill genating data

for j=1:length(x1)-1 % firts data point and second data point, second data point and third data point,...

target= [x1(j+1) y1(j+1)]; % new data will generate towards this data pointwhich is the next given data point
bias= (target(2)-y)./(target(1)-x); % gradient between current point and target point

Num_points= (target(1)-x)/inc; %number of new points ging to generate inside this region

for i=1:Num_points
   
    x2 = [x2;x]; %save generated data in x2 matrix
    y2 = [y2;y]; %save generated data in y2 matrix
    x=x+inc; % increase the x value to a new value
    y=y + rang*senst*(randn) + bias*inc; % increment for y, fist part will add random number to present value according to the sensitivity(sensitivity depends on the range of y1 too) 
                                        % second part is biasing new point towards the target point.
    if y<0 % this willavoide negative values for y
        y=0;
    end
end


end
 
plot(x2,y2)
hold off 

final =[x2 y2]'; %combine x2 and y2 matrices

%%write data into a csv file.

cHeader = {'x ' 'y'}; %variable names as you want
textHeader = strjoin(cHeader, ',') ; %add "," between names

fid = fopen('generated data.csv','w+'); % open or write new csv file called "myCSV". w+ menns over writing 
fprintf(fid,'%s\r\n',textHeader); %write text hedder to csv. '%s\r\n' is the format. % = thing you write, s = string, \r = carriage return, \n = new line  
fclose(fid); %writing is done

fid = fopen('generated data.csv','a+');% open or write new csv file called "myCSV". a+ menns append data to end of the file
fprintf(fid,'%5.5f,%4.10f\r\n',final); %write text hedder to csv. '%5.6f,%4.6f\r\n is the format. % = thing you write, f = Fixed-point notation, 5.6 =five digits before decimal point and 6 digith after
fclose(fid);%writing is done