%Input signals for the NI device are output voltages from photodiodes
%Output voltages form NI device are inputs for LEDs

clc,clear  % erase the command window and workspace

N =3; %number of acquisitions 

for i=1:N

 time =  rand(1000,1);
 PhotoD1 = rand(1000,1);
 
 
%% save data as a csv file
M= [time PhotoD1]'; %Transpose of the matrix (now it has two columns) 

cHeader = {'time ' 'PhotoD1'};  %write variable names on the top of the csv file (as you want)
textHeader = strjoin(cHeader, ',') ; %add "," between names, str is string which includes letters

%
% making a file name for the csv file
string = int2str(i); % convert integer i in to a string
C = {'PhotodetectorReadings',string,'.csv'}; % make a cell with strings
file_name = strjoin(C); %combine strings in the cell
%
%

fid = fopen(file_name,'w+'); % open or write new csv file called "NI_USB_6008.csv". w+ means over writing 
fprintf(fid,'%s\r\n',textHeader); %write text hedder to csv. '%s\r\n' is the format. % = thing you write, s = string (letter, for example time or voltage), \r = carriage return, \n = new line (another line) 
fclose(fid); %writing is done

fid = fopen(file_name,'a+');% open or write new csv file called "NI_USB_6008.csv". a+ menns appending data to end of the file
fprintf(fid,'%5.6f,%4.10f,\r\n',M); %write text hedder to csv. '%5.6f,%4.6f\r\n is the format. % = thing you write, f = Fixed-point notation, 5.6 =five digits before decimal point and 6 digith after
fclose(fid);%writing is done

disp('Data has been saved to PhotodetectorReadings.csv');%display this phrase on command window

end