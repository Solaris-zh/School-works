clear;


rng('default');
rng(0);
key_e=uint8(round(255*rand(256)));%�������һ��ͼ�������Կkey_e


P = imread('girl.bmp');%���ٸı䵽���ĸ�����λ������ȫ���أ�ǰ��������

B = bitxor(P, key_e);
imwrite(B,'����ͼ��.bmp');




msgfid=fopen('������Ϣ.txt','r');
[msg,msgcount]=fread(msgfid);       %���ֽ���ʽ��,0~255
fclose(msgfid);




msg = str2bit(msg);
ends=[0,0,0,0,0,0,0,0];
msg=[msg,ends];
msg = msg';  %ת��
msgcount=msgcount*8+8;%msgcountҪ����





%һ������t��bit    һ��k������
%floor(msgcount/3)����n-1��3bit    ÿ����Ҫ8�飬���8��ֻҪ����3����

s = floor(sqrt(256*256/(msgcount/3*8)));      %��������ô���飬һ��8��
k = 8;
t = 3;
g = (floor(256/s))^2;       
o = (floor(    msgcount/3   )*8);%��Ҫo��
%ԭ���Ĵ��������ceil����������

                



rng('default');
rng(1);
key_h = randperm(g,o);%һ������Ϊo��ȡֵ��Χ��1��g֮���������е���������          ������Կ������Կ˳��ÿk��Ϊһ��




for i = 1 :  msgcount
    if i*3<=msgcount
        m(i)=bin2dec(toStr(msg(i*3-2:i*3)));
    end;
end;

%m���ǰѱ�������һ�� msgcount120   m 40


for i=1:size(m')
    mi = key_h(m(i)+i*k-7)-1;   %key_h�˸��˸��ģ�ÿ������-7Ȼ��������Ӹ�ֵ�����ֵ��m����
    x = (floor(mi/floor(256/s)))*s+1;  %mi�ķ�Χ��(floor(256/s))^2
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
imwrite(B,'����ͼ��_������Ϣ.bmp');

