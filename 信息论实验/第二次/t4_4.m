PYx = [1/3, 1/3, 1/6, 1/6; 1/6, 1/3, 1/6, 1/3];


Px = [0.5,0.5];


p = [1/3, 1/3, 1/6, 1/6];
H_Yx = -sum(p .* log2(p));


Py = Px*PYx;
H_y = -sum(Py .* log2(Py));


C = H_y - H_Yx;
