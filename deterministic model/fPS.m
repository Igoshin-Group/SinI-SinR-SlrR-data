function [x,fval,exitflag,output]=fPS()
options = optimoptions('particleswarm','OutputFcn',@outfun,'Display','iter','SwarmSize',20);

problem.options = options;
problem.solver = 'particleswarm';
problem.objective = @(x)fError(x);
problem.x0 = [ 1.1661   24.9862   40.0000   80.2121    1.0000    0.5000  214.7179   39.6674];
problem.lb = [0.02,10,10,10,0.5,0.25,5,10];
problem.ub = [2,70,140,210,60,16,300,1000];
problem.nvars=8;
function stop = outfun(values,state)
         values.bestx
         stop=0;
 end
[x,fval,exitflag,output]=particleswarm(problem);
end