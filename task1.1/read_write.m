global A = csvread('sensor_data.csv');  #do not change this line

################################################
#######Declare your global variables here#######
################################################

global axl=A(1:8000,2);
global axh=A(1:8000,1);
global ayl=A(1:8000,4);
global ayh=A(1:8000,3);
global azl=A(1:8000,6);
global azh=A(1:8000,5);
global gxl=A(1:8000,8);
global gxh=A(1:8000,7);
global gyl=A(1:8000,10);
global gyh=A(1:8000,9);
global gzl=A(1:8000,12);
global gzh=A(1:8000,11);
global f_cut=5;

################################################

function read_accel(axl,axh,ayl,ayh,azl,azh)  
  #################################################
  ####### Write a code here to combine the ########
  #### HIGH and LOW values from ACCELEROMETER #####
  #################################################
  for j=1:8000
    temp=strcat(num2str(axh(j,1)),num2str(axl(j,1)));
    ax(j,1)=str2num(temp);
    temp=strcat(num2str(ayh(j,1)),num2str(ayl(j,1)));
    ay(j,1)=str2num(temp);
    temp=strcat(num2str(azh(j,1)),num2str(azl(j,1)));
    az(j,1)=str2num(temp);
  endfor

  ####################################################
  # Call function lowpassfilter(ax,ay,az,f_cut) here #
  ####################################################
  lowpassfilter(ax,ay,az,f_cut)

endfunction

function read_gyro(gxl,gxh,gyl,gyh,gzl,gzh)
  
  #################################################
  ####### Write a code here to combine the ########
  ###### HIGH and LOW values from GYROSCOPE #######
  #################################################
  
  for j=1:8000
    temp=strcat(num2str(gxh(j,1)),num2str(gxl(j,1)));
    gx(j,1)=str2num(temp);
    temp=strcat(num2str(gyh(j,1)),num2str(gyl(j,1)));
    gy(j,1)=str2num(temp);
    temp=strcat(num2str(gzh(j,1)),num2str(gzl(j,1)));
    gz(j,1)=str2num(temp);
  endfor

  #####################################################
  # Call function highpassfilter(ax,ay,az,f_cut) here #
  #####################################################;

endfunction


function lowpassfilter(ax,ay,az,f_cut)
  dT = 1/200;  #time in seconds
  Tau= 10;
  alpha = Tau/(Tau+dT);                #do not change this line
  
  ################################################
  ##############Write your code here##############
  ################################################
  
  
endfunction



function highpassfilter(gx,gy,gz,f_cut)
  dT = 1/200;  #time in seconds
  Tau= 10;
  alpha = Tau/(Tau+dT);                #do not change this line
  
  ################################################
  ##############Write your code here##############
  ################################################
  
endfunction

function comp_filter_pitch(ax,ay,az,gx,gy,gz)

  ##############################################
  ####### Write a code here to calculate  ######
  ####### PITCH using complementry filter ######
  ##############################################

endfunction 

function comp_filter_roll(ax,ay,az,gx,gy,gz)

  ##############################################
  ####### Write a code here to calculate #######
  ####### ROLL using complementry filter #######
  ##############################################

endfunction 

function execute_code
  for n = 1:rows(A)                    #do not change this line
    
    ###############################################
    ####### Write a code here to calculate  #######
    ####### PITCH using complementry filter #######
    ###############################################
    
  endfor
  csvwrite('output_data.csv',B);        #do not change this line
endfunction


execute_code                           #do not change this line
