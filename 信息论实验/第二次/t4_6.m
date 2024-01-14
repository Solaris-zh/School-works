PYx = [0.5,0.2,0.3;0.4,0.4,0.2;0.1,0.3,0.6];


syms x y z
eq1 = sum([x,y,z].*PYx(1,:),2)== -sum(PYx(1,:) .* log2(PYx(1,:)));
eq2 = sum([x,y,z].*PYx(2,:),2)== -sum(PYx(2,:) .* log2(PYx(2,:)));
eq3 = sum([x,y,z].*PYx(3,:),2)== -sum(PYx(3,:) .* log2(PYx(3,:)));
sol=solve([eq1,eq2,eq3],[x,y,z]);





C = log2(sum(2.^[-sol.x,-sol.y,-sol.z],2));


py1 = 2^(-sol.x-C);
py2 = 2^(-sol.y-C);
py3 = 2^(-sol.z-C);

Px = [py1,py2,py3]*PYx;