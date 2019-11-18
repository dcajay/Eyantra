global A = csvread('sensor_data.csv');  #do not change this line
global n1=2;
global n2=2;
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
global pitch=zeros(1,1);
global roll=zeros(1,1);
  
################################################

function read_accel(axl,axh,ayl,ayh,azl,azh)  
  global axl axh ayl ayh axl azl azh f_cut ax ay az;
  for j=1:100
    ax(j,1) = (bitshift(axh(j,1),8)+axl(j,1));
    ay(j,1) = (bitshift(ayh(j,1),8)+ayl(j,1));
    az(j,1) = (bitshift(azh(j,1),8)+azl(j,1));
  endfor

  lowpassfilter(ax,ay,az,f_cut)

endfunction

function read_gyro(gxl,gxh,gyl,gyh,gzl,gzh)
  
  global gxl gxh gyl gyh gxl gzl gzh f_cut gx gy gz;
  for j=1:100
    gx(j,1) = (bitshift(gxh(j,1),8)+gxl(j,1));
    gy(j,1) = (bitshift(gyh(j,1),8)+gyl(j,1));
    gz(j,1) = (bitshift(gzh(j,1),8)+gzl(j,1));
  endfor

  highpassfilter(ax,ay,az,f_cut)
endfunction


function lowpassfilter(ax,ay,az,f_cut)

  global f_cut;
  dT = 0.01;  #time in seconds
  Tau= 1/(2*3.14*f_cut);
  alpha = Tau/(Tau+dT);  #do not change this line
  ax = [zeros(1,1), ax(1:end)];
  ay = [zeros(1,1), ay(1:end)];
  az = [zeros(1,1), az(1:end)];

  for i= 1:100
    f(i,1) = (1-alpha)*ax(i,1) + alpha*f(i,1);
    g(i,1) = (1-alpha)*ay(i,1) + alpha*g(i,1);
    h(i,1) = (1-alpha)*az(i,1) + alpha*h(i,1);
  endfor
  ax=f;
  ay=g;
  az=h;  

endfunction



function highpassfilter(gx,gy,gz,f_cut)

  global f_cut;
  dT = 1/200;  #time in seconds
  Tau= 10;
  alpha = Tau/(Tau+dT);                #do not change this line
  gx = [zeros(1,1), gx(1:end)];
  gy = [zeros(1,1), gy(1:end)];
  gz = [zeros(1,1), gz(1:end)];

  for  i=1:100
    f(i,1) = (1-alpha)*f(i,1) + (1-alpha)*(gx(i,1)-gx(i,1));
    g(i,1) = (1-alpha)*g(i,1) + (1-alpha)*(gy(i,1)-gy(i,1));
    h(i,1) = (1-alpha)*h(i,1) + (1-alpha)*(gz(i,1)-gz(i,1));
  endfor
  gx=f;
  gy=g;
  gz=h;
  
endfunction

function comp_filter_pitch(ax,ay,az,gx,gy,gz)

  dT = 0.01;  #time in seconds
  Tau= 1/(2*3.14*f_cut);
  alpha = Tau/(Tau+dT);  #do not change this line
  acc=atan((ay-ay1)/(az-az1));
  gyro=gx;
  pitch(n2,1)=0.97*(pitch1+gyro*0.01)+ 0.03*(acc);
  ay1=ay;
  gx1=gx;
  az1=az; 
  pitch1=pitch;
  n2++;
endfunction 

function comp_filter_roll(ax,ay,az,gx,gy,gz)
  dT = 0.01;  #time in seconds
  Tau= 1/(2*3.14*f_cut);
  alpha = Tau/(Tau+dT);  #do not change this line
  acc=atan((ax-ax1)/(az-az1));
  gyro=gy;
  roll(n1,1)=0.97*(roll1+gyro*0.01)+0.03*(acc);
  ax1=ax;
  az1=az; 
  gy1=gy;
  roll1=roll;
  n1++;
  
endfunction 

function execute_code
  global A ax ay az gx gy gz ;

  for n = 1:rows(A)                    #do not change this line
   
   comp_filter_pitch(ax(n,1),ay(n,1),az(n,1),gx(n,1),gy(n,1),gz(n,1))
   comp_filter_roll(ax(n,1),ay(n,1),az(n,1),gx(n,1),gy(n,1),gz(n,1)) 
    
  endfor

  B=[pitch roll];
  plot(B)
  csvwrite('output_data.csv',B);        #do not change this line
endfunction


execute_code                           #do not change this line