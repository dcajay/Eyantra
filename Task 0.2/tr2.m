pkg load symbolic 
pkg load control     # Load the octave symbolic library
syms x1 x2             # Define symbolic variables x1 and x1

a = -x1 + 2*x1^3 + x2;       # Write the expressions for x1_dot and x2_dot
b = -x1 - x2; 
a == 0;
b == 0; 
eqbm_points=find_equilibrium_points(a,b);
jacobian_matrices=find_jacobian_matrices(ret,a,b);
syms jacmat
  solutions=jacobian([x1_dot x2_dot],[x1,x2]);
  disp(solutions)
  syms k
  
    for k = 1:length(eqbm_points)
    x_1 = eqbm_points{k}.x1;
    mat{1,k}=subs(solutions,x1,x_1);
    disp(jacobian_matrices);
    jacobian_matrices=[jacobian_matrices;cell2mat(mat)]
    endfor 
    disp(mat);
