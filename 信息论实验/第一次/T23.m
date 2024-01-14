PX = [0.5,0.5]; PYx = [0.98,0.2;0.02,0.8];

PXY1 = (PYx(1,:) * PX(1));
PXY2 = (PYx(2,:) * PX(2));
PXY = [PXY1;PXY2];

PY = sum(PXY,2);
PXy1 = PXY(1,:) / PY(1);
PXy2 = PXY(2,:) / PY(2);
PXy = [PXy1;PXy2];

HX = -sum(PX.*log2(PX));
HXy= -sum(sum(PXY.*log2(PXy)));


% 平均互信息量I(X;Y)
IX_Y = HX - HXy;

% 疑义度H(X/Y)
HXy = -sum(sum((PXY.*log2(PXy))));

%噪声熵H(Y/X)

HY = -sum(PY.*log2(PY));

HYx = HY - IX_Y;

% 联合熵H(XY)
HXY = -sum(sum(PXY*log2(PXY)));


















