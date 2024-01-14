%2.1
PX = [1/2,1/4,1/8,1/8];
HX = -sum(PX.*log2(PX));

%2.2
Pxy = [1/8,3/8;3/8,1/8];
Px=[1/2;1/2];
Py=[1/2;1/2];

HXY1 = -sum(Pxy.*log2(Pxy./Py));
HXY1 = sum(HXY1);

HXY2 = -sum(Pxy.*log2(Pxy));
HXY2 = sum(HXY2);


Hx = -sum(Px.*log2(Px));
HY = Hx;


HYx = -sum(Pxy.*log2(Pxy./Px));
HYx = sum(HYx);

IY_X = HY-HYx;
IX_Y = HX-HXY1;





