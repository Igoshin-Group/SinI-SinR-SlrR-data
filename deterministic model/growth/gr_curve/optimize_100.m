function s=optimize_100()
options = optimoptions('fmincon','OutputFcn',@outfun,'Display','iter');
 
function stop = outfun(x,optimValues,state)
     stop = false;
 
     switch state
         case 'init'
         case 'iter'
         % Concatenate current point and objective function
         % value with history. x must be a row vector.b
         x
         otherwise
     end
 end
s=fmincon('error_100',[  1.6341    1.7101   80.6183    0.5    2 8 0.05],[],[],[],[],[0,0,20,0,1,0,0.02],[200,2,500,1.5,5,100,0.3],[],options)
end