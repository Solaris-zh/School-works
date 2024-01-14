
a1 = 1/2;
a2 = 1/4;
a3 = 1/4;
PX = [a1,a2,a3];
X = [];
n=0;
m=3;
for i=1:m
    for j=1:m
        n=n+1;
        

        X(n)=PX(i)*PX(j);
    end 
end

H2 = -sum(X.*log2(X));


Y = [];
n=0;
m=3;
for i=1:m
    for j=1:m
        for k=1:m
            for l=1:m
            n=n+1;
            Y(n)=PX(i)*PX(j);
            end
        end     
    end 
end

H4 = -sum(Y.*log2(Y));




