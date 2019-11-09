a=csvread('sensor_data.csv');
for j=1:1000
  temp=strcat(num2str(a(j,1)),num2str(a(j,2)));
  ax(j,1)=(str2num(temp))/16384;
  temp=strcat(num2str(a(j,2)),num2str(a(j,4)));
  ay(j,1)=(str2num(temp))/16384;
  temp=strcat(num2str(a(j,5)),num2str(a(j,6)));
  az(j,1)=(str2num(temp))/16384;
  temp=strcat(num2str(a(j,7)),num2str(a(j,8)));
  gx(j,1)=(str2num(temp))/131;
  temp=strcat(num2str(a(j,9)),num2str(a(j,10)));
  gy(j,1)=(str2num(temp))/131;
  temp=strcat(num2str(a(j,11)),num2str(a(j,12)));
  gz(j,1)=(str2num(temp))/131;

  endfor
dt = 1/200;  
Tau= 0.25;
alpha = Tau/(Tau+dt);
f(1,1)=0;
#for i=2:100
#  f(i,1) = (1-alpha)*ax(i,1) + alpha*f(i-1,1);
#endfor
#[b,a]=butter(2,0.01,'low');
#dy=filter(b,a,ax);
#ax=dy;
#dx=filter(alpha,alpha,ax);
#f(1:8000,2)=dy;
#f(1:8000,3)=dx;  
#fk2=f(1:10,1:3)
#t=1:500;
#plot(t,ax(501:1000,1),t,dy(501:1000,1),'g',t,f(501:1000,1),'r');


#for pitch
acc(:,1)= ax;
acc(:,2)= ay;
gyro=gx;
pitch=[0];
pitch =(1-alpha)*(pitch+gyro*dt)+alpha*acc;
pitch_=pitch(1:10,:)
#for roll

acc(:,1)= ax;
acc(:,2)= az;
gyro=gy;
roll=[0];
roll=(1-alpha)*(pitch+gyro*dt)+alpha*acc;
t=[pitch roll];
roll_=roll(1:10,:)
