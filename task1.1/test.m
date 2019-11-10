a=csvread('sensor_data.csv');
#read accel
for j=1:800
  num1=num2str(de2bi(a(j,1))); num1=num1(~isspace(num1));
  num2=num2str(de2bi(a(j,2))); num2=num2(~isspace(num2));
  temp=strcat(num1,num2);
  s=bin2dec(temp);
    if s>32767
      ax(j,1)=(s-65536)/16384;
    else 
      ax(j,1)=s/16384;
    endif
  num1=num2str(de2bi(a(j,3))); num1=num1(~isspace(num1));
  num2=num2str(de2bi(a(j,4))); num2=num2(~isspace(num2));
  temp=strcat(num1,num2);
  s=bin2dec(temp);
    if s>32767
      ay(j,1)=(s-65536)/16384;
    else 
      ay(j,1)=s/16384;
    endif
  num1=num2str(de2bi(a(j,5))); num1=num1(~isspace(num1));
  num2=num2str(de2bi(a(j,6))); num2=num2(~isspace(num2));
  temp=strcat(num1,num2);
  s=bin2dec(temp);
    if s>32767
      az(j,1)=(s-65536)/16384;
    else 
      az(j,1)=s/16384;
    endif
#read gyro  
  num1=num2str(de2bi(a(j,7))); num1=num1(~isspace(num1));
  num2=num2str(de2bi(a(j,8))); num2=num2(~isspace(num2));
  temp=strcat(num1,num2);
  s=bin2dec(temp);
    if s>32767
      gx(j,1)=(s-65536)/131;
    else 
      gx(j,1)=s/131;
    endif
    num1=num2str(de2bi(a(j,9))); num1=num1(~isspace(num1));
  num2=num2str(de2bi(a(j,10))); num2=num2(~isspace(num2));
  temp=strcat(num1,num2);
  s=bin2dec(temp);
    if s>32767
      gy(j,1)=(s-65536)/131;
    else 
      gy(j,1)=s/131;
    endif
  num1=num2str(de2bi(a(j,11))); num1=num1(~isspace(num1));
  num2=num2str(de2bi(a(j,12))); num2=num2(~isspace(num2));
  temp=strcat(num1,num2);
  s=bin2dec(temp);
    if s>32767
      gz(j,1)=(s-65536)/131;
    else 
      gz(j,1)=s/131;
    endif
endfor
#lowpassfilter
f_cut=5;
dT = 0.01;  #time in seconds
Tau= 1/(2*3.14*f_cut);
alpha = Tau/(Tau+dT);  #do not change this line
f(1,1)=ax(1,1);
g(1,1)=ay(1,1);
h(1,1)=az(1,1);
for i=2:800
  f(i,1) = (1-alpha)*ax(i,1) + alpha*f(i-1,1);
  g(i,1) = (1-alpha)*ay(i,1) + alpha*g(i-1,1);
  h(i,1) = (1-alpha)*az(i,1) + alpha*h(i-1,1);
endfor
t=1:800;
#subplot(311)
#plot(t,ax(1:800,1),'r',t,f(1:800,1))
ax=f;
ay=g;
az=h;  

#highpassfilter
f(1,1)=gx(1,1);
g(1,1)=gy(1,1);
h(1,1)=gz(1,1);
for i=2:800
  f(i,1) = (1-alpha)*f(i-1,1) + (1-alpha)*(gx(i,1)-gx(i-1,1));
  g(i,1) = (1-alpha)*g(i-1,1) + (1-alpha)*(gy(i,1)-gy(i-1,1));
  h(i,1) = (1-alpha)*h(i-1,1) + (1-alpha)*(gz(i,1)-gz(i-1,1));
endfor
#subplot(312)
#plot(t,gx(1:800,1),'r',t,f(1:800,1))
gx=f;
gy=g;
gz=h;

#pitch and roll  
alpha=0.03;
pitch(1:800,1)=zeros(1,1);
roll(1:800,1)=zeros(1,1);
for n=2:800 
  acc=(real(sqrt(ay(n,1)*ay(n,1)+az(n,1)*az(n,1))));
  gyro=gx(n,1);
  pitch(n,1)=0.97*(pitch(n-1,1)+gyro*dT)+ 0.03*(acc);
  acc1=(real(sqrt(ax(n,1)*ax(n,1)+az(n,1)*az(n,1))));
  gyro=gy(n,1);
  roll(n,1)=0.97*(roll(n-1,1)+gyro*dT)+0.03*(acc1); 
endfor
plot(t,pitch(1:800,1),'y');
##f_cut=5;
##dT = 0.01;  #time in seconds
##Tau= 1/(2*3.14*f_cut);
##alpha = Tau/(Tau+dT);  #do not change this line
##f(1,1)=roll(1,1);
##g(1,1)=pitch(1,1);
##for i=2:800
##  f(i,1) = (1-alpha)*roll(i,1) + alpha*f(i-1,1);
##  g(i,1) = (1-alpha)*pitch(i,1) + alpha*g(i-1,1);
##endfor
##
#printing output  
B=[pitch roll];
csvwrite('output_data.csv',B);
#subplot(313)
#plot(t,roll(1:800,1),'r',t,pitch(1:800,1),'g');