global A = csvread('sensor_data.csv');  #do not change this line

################################################
#######Declare your global variables here#######
################################################


function read_accel(axl,axh,ayl,ayh,azl,azh)  
  a=csvread('sensor_data.csv');
n=6;
for i=1:n
  for j=1:10
    temp=strcat(num2str(a(j,i)),num2str(a(j,i+1)));
    m(j,i)=str2num(temp);
  endfor
endfor
disp(m(8000,1:6));
printf("%d",m(8000,1:6));
#################################################
  ####### Write a code here to combine the ########
  #### HIGH and LOW values from ACCELEROMETER #####
  #################################################


  ####################################################
  # Call function lowpassfilter(ax,ay,az,f_cut) here #
  ####################################################

endfunction

#function read_gyro(gxl,gxh,gyl,gyh,gzl,gzh)
  
  #################################################
  ####### Write a code here to combine the ########
  ###### HIGH and LOW values from GYROSCOPE #######
  #################################################


  #####################################################
  # Call function highpassfilter(ax,ay,az,f_cut) here #
  #####################################################;

#endfunction




#function lowpassfilter(ax,ay,az,f_cut)
  #dT = ;  #time in seconds
 # Tau= ;
 # alpha = Tau/(Tau+dT);                #do not change this line
  
  ################################################
  ##############Write your code here##############
  ################################################
  
#endfunction



#function highpassfilter(gx,gy,gz,f_cut)
  #dT = ;  #time in seconds
  #Tau= ;
  #alpha = Tau/(Tau+dT);                #do not change this line
  
  ################################################
  ##############Write your code here##############
  ################################################
  
#endfunction

#function comp_filter_pitch(ax,ay,az,gx,gy,gz)

  ##############################################
  ####### Write a code here to calculate  ######
  ####### PITCH using complementry filter ######
  ##############################################

#endfunction 

#function comp_filter_roll(ax,ay,az,gx,gy,gz)

  ##############################################
  ####### Write a code here to calculate #######
  ####### ROLL using complementry filter #######
  ##############################################

#endfunction 

#function execute_code
  

  #for n = 1:rows(A)                    #do not change this line
    
    ###############################################
    ####### Write a code here to calculate  #######
    ####### PITCH using complementry filter #######
    ###############################################
    
  #endfor
  #csvwrite('output_data.csv',B);        #do not change this line
#endfunction


execute_code                           #do not change this line
