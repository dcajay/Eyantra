global A = csvread('sensor_data.csv');  #do not change this line

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
global graph
################################################

function read_accel(axl,axh,ayl,ayh,azl,azh)  
  global f_cut;
  for j=1:8000
    ax(j,1) = (bitshift(axh(j,1),8)+axl(j,1));
    if ax(j,1)>32767
      ax(j,1)=(ax(j,1)-65536)/16384;
    else 
      ax(j,1)=ax(j,1)/16384;
    endif
    ay(j,1) = (bitshift(ayh(j,1),8)+ayl(j,1));
    if ay(j,1)>32767
      ay(j,1)=(ay(j,1)-65536)/16384;
    else 
      ay(j,1)=ay(j,1)/16384;
    endif
    az(j,1) = (bitshift(azh(j,1),8)+azl(j,1));
    if az(j,1)>32767
      az(j,1)=(az(j,1)-65536)/16384;
    else 
      az(j,1)=az(j,1)/16384;
    endif
  endfor
  lowpassfilter(ax,ay,az,f_cut)

endfunction

function read_gyro(gxl,gxh,gyl,gyh,gzl,gzh)
  global f_cut;
  for j=1:8000
    gx(j,1) = (bitshift(gxh(j,1),8)+gxl(j,1));
    if gx(j,1)>32767
      gx(j,1)=(gx(j,1)-65536)/131;
    else 
      gx(j,1)=gx(j,1)/131;
    endif
    gy(j,1) = (bitshift(gyh(j,1),8)+gyl(j,1));
    if gy(j,1)>32767
      gy(j,1)=(gy(j,1)-65536)/131;
    else 
      gy(j,1)=gy(j,1)/131;
    endif
    gz(j,1) = (bitshift(gzh(j,1),8)+gzl(j,1));
    if gz(j,1)>32767
      gz(j,1)=(gz(j,1)-65536)/131;
    else 
      gz(j,1)=gz(j,1)/131;
    endif
  endfor

  highpassfilter(gx,gy,gz,f_cut)
endfunction


function lowpassfilter(ax,ay,az,f_cut)
  f_cut=5;
  dT = 0.01;  #time in seconds
  Tau= 1/(2*3.14*f_cut);
  alpha = Tau/(Tau+dT);  #do not change this line
  f(1,1)=ax(1,1);
  g(1,1)=ay(1,1);
  h(1,1)=az(1,1);

  for i= 2:8000
    f(i,1) = (1-alpha)*ax(i,1) + alpha*f(i-1,1);
    g(i,1) = (1-alpha)*ay(i,1) + alpha*g(i-1,1);
    h(i,1) = (1-alpha)*az(i,1) + alpha*h(i-1,1);
  endfor
  global ax=f;
  global ay=g;
  global az=h;
endfunction



function highpassfilter(gx,gy,gz,f_cut)
  f_cut=5;
  dT = 0.01;  #time in seconds
  Tau= 1/(2*3.14*f_cut);
  alpha = Tau/(Tau+dT);  #do not change this line
  f(1,1)=gx(1,1);
  g(1,1)=gy(1,1);
  h(1,1)=gz(1,1);
  for  i=2:8000
    f(i,1) = (1-alpha)*f(i-1,1) + (1-alpha)*(gx(i,1)-gx(i-1,1));
    g(i,1) = (1-alpha)*g(i-1,1) + (1-alpha)*(gy(i,1)-gy(i-1,1));
    h(i,1) = (1-alpha)*h(i-1,1) + (1-alpha)*(gz(i,1)-gz(i-1,1));
  endfor
  global gx=f;
  global gy=g;
  global gz=h;
endfunction

function comp_filter_pitch(ax,ay,az,gx,gy,gz)
  a = ay
  alpha=0.03;
  pitch(1:8000,1)=zeros(1,1);
  pitch(1,1)=gx(1,1);
  for n=2:8000
    acc=atan(ay(n,1)/az(n,1));
    gyro=gx(n,1);
    pitch(n,1)=0.97*(pitch(n-1,1)+gyro*0.01)+ 0.03*(acc);
  endfor
  global p = pitch;
endfunction 

function comp_filter_roll(ax,ay,az,gx,gy,gz)

  alpha=0.03;
  roll(1:8000,1)=zeros(1,1);
  roll(1,1)=gy(1,1);
  for n=2:8000
    acc1=atan(ax(n,1)/az(n,1));
    gyro=gy(n,1);
    roll(n,1)=0.97*(roll(n-1,1)+gyro*0.01)+0.03*(acc1); 
  endfor
  global r = roll;
endfunction 

function execute_code
  global A axl axh ayl ayh azl azh gxl gxh gyl gyh gzl gzh;
  read_accel(axl,axh,ayl,ayh,azl,azh)
  read_gyro(gxl,gxh,gyl,gyh,gzl,gzh)
  global ax ay az gx gy gz;
  comp_filter_pitch(ax,ay,az,gx,gy,gz)
  comp_filter_roll(ax,ay,az,gx,gy,gz)
  for n = 1:rows(A)                    #do not change this line
    data(1,:) = A(n,:);
  endfor
  global p r;
  B=[p r];
  csvwrite('output_data.csv',B);        #do not change this line
endfunction


execute_code                           #do not change this line
