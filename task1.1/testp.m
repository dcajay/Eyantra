A = csvread('sensor_data.csv');
global axl=A(1:8000,1);
global ns =zeros(8000,1); 

function Convert_num(num)
	for n = length(num)
		ns(n)= de2bi(num(n));
	endfor
endfunction

Convert_num(axl);
