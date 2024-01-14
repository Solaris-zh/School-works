PYx = [0.9,0.1;0.2,0.8];






syms x y
eq1 = sum([x,y].*PYx(1,:), 2)== -sum(PYx(1,:) .* log2(PYx(1,:)));
eq2 = sum([x,y].*PYx(2,:), 2)== -sum(PYx(2,:) .* log2(PYx(2,:)));
sol=solve([eq1,eq2],[x,y]);



C = log2(sum(2.^[-sol.x,-sol.y],2));


py1 = 2^(-sol.x-C);
py2 = 2^(-sol.y-C);

Px = [py1,py2]*PYx;
