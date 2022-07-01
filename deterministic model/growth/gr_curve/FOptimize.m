function s=FOptimize()
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
s=fmincon('FerrorDSM',[37.1700    1.6344    7.2974    1.0000    1.2151    0.6587    1.5145],[],[],[],[],[0,0,0,1,0.1,0,0],[200,15,1000,1,5,5,2],[],options)
end