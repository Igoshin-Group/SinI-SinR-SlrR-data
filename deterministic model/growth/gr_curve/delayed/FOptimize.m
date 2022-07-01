function [x,fval,exitflag,output]=fFit()
options = optimoptions('particleswarm','OutputFcn',@outfun,'Display','iter','SwarmSize',150);

problem.options = options;
problem.solver = 'particleswarm';
problem.objective = @(x)Ferrormsgg(x);

problem.x0 = [    11.0548    0.7000    8.2220    1.0000    0.4593    2.7830    5.0000    0.8631   60.0000   20.0000    0.2188
];
problem.lb = [1,1,2,1,0.05,0.5,0.1,0.05,10,1,0.05];
problem.ub = [200,3,30,3,0.6,10,5,1,40,20,0.5];
problem.nvars=11;
function stop = outfun(values,state)
         values.bestx
         stop=0;
 end
[x,fval,exitflag,output]=particleswarm(problem);
end