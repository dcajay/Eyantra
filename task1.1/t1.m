a=csvread('sensor_data.csv');
n=6;
for i=1:n
  for j=1:size(a,1)
    temp=strcat(num2str(a(j,i)),num2str(a(j,i+1)));
    m(j,i)=str2num(temp);
  endfor
  i++
endfor
disp(m(8000,1:6));