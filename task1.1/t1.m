a=csvread('sensor_data.csv');
for j=1:size(a)
    temp=strcat(num2str(a(j,1)),num2str(a(j,2)));
    m(j,1)=str2num(temp);
endfor
for j=1:size(a)
    temp=strcat(num2str(a(j,3)),num2str(a(j,4)));
    m(j,2)=str2num(temp);
endfor
for j=1:size(a)
    temp=strcat(num2str(a(j,5)),num2str(a(j,6)));
    m(j,3)=str2num(temp);
endfor
for j=1:size(a)
    temp=strcat(num2str(a(j,7)),num2str(a(j,8)));
    m(j,4)=str2num(temp);
endfor
for j=1:size(a)
    temp=strcat(num2str(a(j,9)),num2str(a(j,10)));
    m(j,5)=str2num(temp);
endfor
for j=1:size(a)
    temp=strcat(num2str(a(j,11)),num2str(a(j,12)));
    m(j,6)=str2num(temp);
endfor

#disp(m);
for n=1:size(a)
  y(n)=fft(a(n));
endfor
#disp(y(8000));
#lpf=designfilt('lowpassfir','Stopbandfrequency',0.7957747); this doesnt work designfilt doesnt work in octave
lpf=fir1(1,0.7957747,'low');
disp(lpf); #filter coef are displayed
dataout = filtfilt(lpf,1,a);# y can be used , it is fast fourier transform of data

hpf=fir1(2,0.7957747,'high');
disp(hpf); #filter coef are displayed
dataout2 = filtfilt(hpf,1,a);# y can be used , it is fast fourier transform of data

#disp(dataout);
#plot(dataout);
#plot(a);