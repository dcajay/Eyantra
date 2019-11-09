pkg load symbolic      
syms x2 x1             
#enter your equations of motion
x1_dot = x1*x2-x2;       
x2_dot = 2*x1 - x2*x2;   

x1_dot == 0;
x2_dot == 0;
eqns=[x1_dot x2_dot];
eqbm_points = solve(eqns);
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
  eigen_values = {};
  for k = 1:length(jacobian_matrices)
    matrix = jacobian_matrices{k};
    flag = 1;
    e=eig(matrix);
    eigen_values{k}=e;
    num1=eigen_values{k}(1);
    num2=eigen_values{k}(2);
    argument=arg(num1);
    if argument==pi
      val1=double(num1);
      val2=double(num2);
      if val1>=0 || val2>=0
        flag =0;
      endif
    else
      val=real(num1);
      if val>0
        flag=0;
      endif
    endif
    if flag == 1
      fprintf("The A matrix is ");
      disp(jacobian_matrices(k))
    endif
  endfor
