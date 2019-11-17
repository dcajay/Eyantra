
pkg load signal;

a=csvread('sensor_data.csv');
#read accel
for j=1:800
    s=bin2dec(strcat(dec2bin(a(j,1),8),dec2bin(a(j,2),8)));
    if s>32767
      ax(j,1)=(s-65536)/16384;
    else 
      ax(j,1)=s/16384;
    endif
  s=bin2dec(strcat(dec2bin(a(j,3),8),dec2bin(a(j,4),8)));
      if s>32767
      ay(j,1)=(s-65536)/16384;
    else 
      ay(j,1)=s/16384;
    endif
  s=bin2dec(strcat(dec2bin(a(j,5),8),dec2bin(a(j,6),8)));
      if s>32767
      az(j,1)=(s-65536)/16384;
    else 
      az(j,1)=s/16384;
    endif
#read gyro  
  s=bin2dec(strcat(dec2bin(a(j,7),8),dec2bin(a(j,8),8)));
       if s>32767
     gx(j,1)=(s-65536)/131;
    else 
      gx(j,1)=s/131;
    endif
  s=bin2dec(strcat(dec2bin(a(j,9),8),dec2bin(a(j,10),8)));
        if s>32767
      gy(j,1)=(s-65536)/131;
    else 
      gy(j,1)=s/131;
    endif
  s=bin2dec(strcat(dec2bin(a(j,11),8),dec2bin(a(j,12),8)));
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

for i= 2:800
  f(i,1) = (1-alpha)*ax(i,1) + alpha*f(i-1,1);
  g(i,1) = (1-alpha)*ay(i,1) + alpha*g(i-1,1);
  h(i,1) = (1-alpha)*az(i,1) + alpha*h(i-1,1);
endfor
ax=f;
ay=g;
az=h;
#highpassfilter
f(1,1)=gx(1,1);
g(1,1)=gy(1,1);
h(1,1)=gz(1,1);

for  i=2:800
  f(i,1) = (1-alpha)*f(i-1,1) + (1-alpha)*(gx(i,1)-gx(i-1,1));
  g(i,1) = (1-alpha)*g(i-1,1) + (1-alpha)*(gy(i,1)-gy(i-1,1));
  h(i,1) = (1-alpha)*h(i-1,1) + (1-alpha)*(gz(i,1)-gz(i-1,1));
endfor
gx=f;
gy=g;
gz=h;

#pitch and roll  
alpha=0.03;
pitch(1:800,1)=zeros(1,1);
roll(1:800,1)=zeros(1,1);
pitch(1,1)=gx(1,1);
roll(1,1)=gy(1,1);
for n=2:800
  acc=atan(ay(n,1)/az(n,1));
  gyro=gx(n,1);
  pitch(n,1)=0.97*(pitch(n-1,1)+gyro*0.01)+ 0.03*(acc);
  acc1=atan(ax(n,1)/az(n,1));
  gyro=gy(n,1);
  roll(n,1)=0.97*(roll(n-1,1)+gyro*0.01)+0.03*(acc1); 
endfor


#subplot(311);plot(pitch);
#subplot(312);plot(roll);

B=[pitch roll];
csvwrite('output_data.csv',B);
#subplot(211);
#plot(roll);
#subplot(212);
#plot(pitch);
t=1:800;
plot(t,roll(1:800,1),'r',t,pitch(1:800,1),'g');