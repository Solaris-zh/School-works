clear;


rng('default');
rng(0);
key_e=uint8(round(255*rand(256)));

B1 = imread('����ͼ��_������Ϣ.bmp');
P1 = bitxor(B1, key_e);
imwrite(P1,'����ͼ��_������Ϣ.bmp');


s = 19;
k = 8;
t = 3;
g = 169;
o = 168;

rng('default');
rng(1);
key_h = randperm(g,o);

%ǰ�������֤��encodeһ��




m=[];
for i=1:k:size(key_h')
    for a=i:i+k-1
        h = key_h(a)-1;
        x = (floor(h/floor(256/s)))*s+1;
        y = (mod(h,floor(256/s)))*s+1;
        T = P1(x:x+s-1,y:y+s-1);
        f = SI(T);
        for j=1:s
            for kk=2:2:s
                if mod(j,2)==0
                    T(j,kk)=bitset(T(j,kk),4,~bitget(T(j,kk),4));
                else
                    T(j,kk-1)=bitset(T(j,kk-1),4,~bitget(T(j,kk-1),4));
                end;
            end;
        end;
        f1 = SI(T);
        if f>f1
            P1(x:x+s-1,y:y+s-1) = T;
            m=[m,dec2bin(a-i,3)];
            continue;
        end;
    end;
end;
m=m';

%����Ϣ���д������˵�������Ϣ
ends='00000';%��β���
l=0;
for i=1:8:size(m) %��Ϊÿ���ַ�����Ϊ8λ�����Լ��Ϊ8
    if m(i:i+4)==ends'
         l=i-1;
         break;
    end;
end;
m0=m(1:l);

%����ȡ��Ϣд���ļ�����
out=bit2str(toBit(m0));
fid=fopen('��ȡ��Ϣ.txt', 'wt');
fwrite(fid, out);
fclose(fid);

%����ָ���ͼƬ
imwrite(P1,'�ָ�ͼ��.bmp');