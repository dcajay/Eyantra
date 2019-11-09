pkg load symbolic      # Load the octave symbolic library
syms x2 x1             # Define symbolic variables x1 and x1

x1_dot = x1*x2-x2;       
x2_dot = 2*x1 - x2*x2;   
jacobians = find_jacobian_matrices(equilibrium_points, x1_dot, x2_dot);
  
#[equilibrium_points jacobians eigen_values stability] = main_function(x1_dot, x2_dot);
#function eqbm_points = find_equilibrium_points(x1_dot, x2_dot)

x1_dot == 0;
x2_dot == 0;
syms x1 x2  
eqns=[x1_dot x2_dot];
eqbm_points = solve(eqns);
#disp(eqbm_points);
#syms x1 x2
  solutions = {};
  jacobian_matrices = {};
  for k = 1:length(eqbm_points)
    x_1 = eqbm_points{k}.x1;
    x_2 = eqbm_points{k}.x2;
    soln = [x_1 x_2];
    solutions{k} = soln;
  endfor
  mat=jacobian([x1_dot ; x2_dot],[x1,x2]);
  disp(mat)
  for i=1:length(solutions)
    disp(solutions{i}(1));
    jb=subs(mat,{x1,x2},[solutions{i}(1),solutions{i}(2)]);
    disp(jb);
    jacobian_matrices{i}=double(jb);
  endfor
  
  #disp(jacobian_matrices);
  stability = {};
  eigen_values = {};
  for k = 1:length(jacobian_matrices)
    matrix = jacobian_matrices{k};
    flag = 1;
    ################## ADD YOUR CODE HERE ######################
    e=eig(matrix);
    #disp(e)
    eigen_values{k}=e;
    num1=eigen_values{k}(1);
    num2=eigen_values{k}(2);
    argument=arg(num1);
    #disp(argument);
    if argument==pi
      #printf("the eigen values are real\n");
      val1=double(num1);
      val2=double(num2);
      #disp(val1);
      #disp(val2);
      if val1>=0 || val2>=0
        flag =0;
      endif
    else
      #printf("the eigen values are complex\n");
      val=real(num1);
      #disp(val);
      if val>0
        flag=0;
      endif
    endif
    if flag == 1
      #disp(jacobian_matrices(k))
      fprintf("The A matrix is ");
      disp(jacobian_matrices(k))
      #stability{k} = "Stable";
    else
      #fprintf("The system is unstable for equilibrium point (%d, %d) \n",double(eqbm_points{k}.x1),double(eqbm_points{k}.x2)); 
      #stability{k} = "Unstable";
    endif
  endfor
  










##
##function [equilibrium_points jacobians eigen_values stability] = main_function(x1_dot, x2_dot)
##  pkg load symbolic      # Load the octave symbolic library
##  syms x1 x2             # Define symbolic variables x1 and x1
##  equilibrium_points = find_equilibrium_points(x1_dot, x2_dot);
##  jacobians = find_jacobian_matrices(equilibrium_points, x1_dot, x2_dot);
##  [eigen_values stability] = check_eigen_values(equilibrium_points, jacobians); 
##endfunction
##  
