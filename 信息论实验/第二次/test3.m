p = [0.05,0.29,0.07,0.08,0.14,0.23,0.03,0.11];
N = length(p);

% 将概率排序并获得单步码字排序
code = strings(N-1,N);% 初始化单步过程的码字
reflect = zeros(N-1,N);% 初始化位置对应向量
p_SD = p;% p_SD为每次得到的概率排序数组
for i=1:N-1           % i表示排序后第几个符号
    M = length(p_SD);
    [p_SD,reflect(i,1:M)] = sort(p_SD,'descend');% 将概率从大到小进行排序
    code(i,M) = '1';% 概率最小的是1
    code(i,M-1) = '0';% 概率第二小的暂且定义为0
    p_SD(M-1) = p_SD(M-1)+p_SD(M);% 将最后两个概率相加
    p_SD(M)=[];
end

% 根据位置对应向量和单步过程的码字计算对应码字
CODE = strings(1,N); % 初始化对应码字
for i=1:N
    column = i;
    for m=1:N-1
        [row,column] = find(reflect(m,:)==column);
        disp(find(reflect(m,:)==column));
        disp([row,column]);
        disp(reflect(m,:));
        CODE(1,i) = strcat(CODE(1,i),code(m,column));
        % 将最小的两个概率映射成一个
        if column==N+1-m
            column = column-1;
        end
    end
end
CODE = reverse(CODE);

   

disp(['信号符号  ',num2str(1:N)]);
disp(['对应概率  ',num2str(p)]);
disp(['对应码字  ',CODE]);

