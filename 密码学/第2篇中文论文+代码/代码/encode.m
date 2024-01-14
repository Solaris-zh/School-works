clear;


rng('default');
rng(0);
key_e=uint8(round(255*rand(256)));%随机生成一个图像加密密钥key_e


P = imread('girl.bmp');%至少改变到第四个比特位才能完全隐藏，前三个不行

B = bitxor(P, key_e);
imwrite(B,'加密图像.bmp');




msgfid=fopen('隐藏信息.txt','r');
[msg,msgcount]=fread(msgfid);       %以字节形式打开,0~255
fclose(msgfid);




msg = str2bit(msg);
ends=[0,0,0,0,0,0,0,0];
msg=[msg,ends];
msg = msg';  %转置
msgcount=msgcount*8+8;%msgcount要跟上





%一组隐藏t个bit    一组k个像素
%floor(msgcount/3)就是n-1份3bit    每份需要8块，这个8块只要大于3就行

s = floor(sqrt(256*256/(msgcount/3*8)));      %可以有这么多组，一组8块
k = 8;
t = 3;
g = (floor(256/s))^2;       
o = (floor(    msgcount/3   )*8);%需要o块
%原来的代码这里的ceil函数多余了

                



rng('default');
rng(1);
key_h = randperm(g,o);%一个长度为o、取值范围在1到g之间的随机排列的整数序列          隐藏密钥，按密钥顺序每k块为一组




for i = 1 :  msgcount
    if i*3<=msgcount
        m(i)=bin2dec(toStr(msg(i*3-2:i*3)));
    end;
end;

%m就是把比特三个一组 msgcount120   m 40


for i=1:size(m')
    mi = key_h(m(i)+i*k-7)-1;   %key_h八个八个的，每个区间-7然后再随机加个值，这个值从m里找
    x = (floor(mi/floor(256/s)))*s+1;  %mi的范围是(floor(256/s))^2
    y = (mod(mi,floor(256/s)))*s+1;
    T = B(x:x+s-1,y:y+s-1);
    for j=1:s
        for kk=2:2:s
            if mod(j,2)==0
                T(j,kk)=bitset(T(j,kk),4,~bitget(T(j,kk),4));
            else
                T(j,kk-1)=bitset(T(j,kk-1),4,~bitget(T(j,kk-1),4));
            end;
        end;
    end;
    B(x:x+s-1,y:y+s-1) = T;
end;
imwrite(B,'加密图像_隐藏信息.bmp');

