pkg load symbolic 
pkg load control     # Load the octave symbolic library
syms x1 x2             # Define symbolic variables x1 and x1

a = -x1 + 2*x1^3 + x2;       # Write the expressions for x1_dot and x2_dot
b = -x1 - x2; 
a == 0;
b == 0; 
ret=find_equilibrium_points(a,b);
#disp(ret);
jab=find_jacobian_matrices(ret,a,b);
nu=num2str(jab{1}(1,1));
disp(nu);
#disp(jab{2});
#disp(jab{3});
