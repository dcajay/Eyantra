solutions={};
syms k;
for k=1:length(ret),
  x_1=ret{k}.x1;
  x_2=ret{k}.x2;
  disp(x_1),disp(x_2);
  soln=[x_1 x_2];
  solutions{k}=soln;
endfor
#mat=jacobian([a ; b],[x1,x2]);
#jb_1=subs(mat,solutions{1});
#disp(jb_1);
disp(mat);
for i=1:length(solutions),
  disp(solutions{i}(1));
  jb_1=subs(mat,x1,solutions{i}(1));
  disp(jb_1);
endfor  


#disp(ret);

%eqns=["x1_dot" "x2_dot"];
%eqbm_points = solve(eqns(1),eqns(2));
%disp(eqbm_points)