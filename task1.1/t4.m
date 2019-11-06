a=csvread('sensor_data.csv');
#joining all data
for i=1:2:size(a,2)
  for j=1:size(a,1)
    temp=strcat(num2str(a(j,i)),num2str(a(j,i+1)));
    m(j,(i+1)/2)=str2num(temp);
  endfor
endfor

#for accelerometer
lpf=fir1(1,0.7957747,'low');
ax=m(1:8000,1);
ay=m(1:8000,2);
az=m(1:8000,2);
dx= filtfilt(lpf,1,ax);
dy= filtfilt(lpf,1,ay);
dz= filtfilt(lpf,1,az);
ax=dx;
ay=dy;
az=dz;

#for gyroscope
hpf=fir1(2,0.7957747,'high');
gx=m(1:8000,4);
gy=m(1:8000,5);
gz=m(1:8000,6);
dx= filtfilt(lpf,1,gx);
dy= filtfilt(lpf,1,gy);
dz= filtfilt(lpf,1,gz);
gx=dx;
gy=dy;
gz=dz;

disp(ax(1:10,1))