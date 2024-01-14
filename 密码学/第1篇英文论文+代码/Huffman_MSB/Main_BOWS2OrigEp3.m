clear
clc
%% ������������������
num = 10000000;
rand('seed',0); %��������
D = round(rand(1,num)*1); %�����ȶ������
%% ͼ�����ݼ���Ϣ(BOWS2OrigEp3),��ʽ:PGM,����:10000��
I_file_path = 'D:\ImageDatabase\BOWS2OrigEp3\'; %����ͼ�����ݼ��ļ���·��
I_path_list = dir(strcat(I_file_path,'*.pgm')); %��ȡ���ļ���������pgm��ʽ��ͼ��
img_num = length(I_path_list); %��ȡͼ��������
%% ��¼ÿ��ͼ���Ƕ������Ƕ����
num_BOWS2OrigEp3 = zeros(1,img_num); %��¼ÿ��ͼ���Ƕ���� 
bpp_BOWS2OrigEp3 = zeros(1,img_num); %��¼ÿ��ͼ���Ƕ����
%% ����ͼ�������Կ�����ݼ�����Կ
Image_key = 1;
Data_key = 2;
%% ���ò���(����ʵ���޸�)
ref_x = 1; %������Ϊ�ο����ص�����
ref_y = 1; %������Ϊ�ο����ص�����
%% ͼ�����ݼ�����
for i=1:img_num
    %----------------��ȡͼ��----------------%
    I_name = I_path_list(i).name; %ͼ����
    I = imread(strcat(I_file_path,I_name));%��ȡͼ��
    origin_I = double(I);
    %-----------ͼ����ܼ�����Ƕ��-----------%
    [encrypt_I,stego_I,emD] = Encrypt_Embed(origin_I,D,Image_key,Data_key,ref_x,ref_y);
    num_emD = length(emD);
    if num_emD > 0
        %--------�ڼ��ܱ��ͼ������ȡ��Ϣ--------%
        [Side_Information,Refer_Value,Encrypt_exD,Map_I,sign] = Extract_Data(stego_I,num,ref_x,ref_y);
        if sign == 1
            %---------------���ݽ���----------------%
            [exD] = Encrypt_Data(Encrypt_exD,Data_key);
            %---------------ͼ��ָ�----------------%
            [recover_I] = Recover_Image(stego_I,Image_key,Side_Information,Refer_Value,Map_I,num,ref_x,ref_y);
            %---------------�����¼----------------%
            [m,n] = size(origin_I);
            num_BOWS2OrigEp3(i) = num_emD;   
            bpp_BOWS2OrigEp3(i) = num_emD/(m*n);
            %---------------����ж�----------------%
            check1 = isequal(emD,exD);
            check2 = isequal(origin_I,recover_I);
            if check1 == 1 
                disp('��ȡ������Ƕ��������ȫ��ͬ��') 
            else
                disp('Warning��������ȡ����')
            end
            if check2 == 1
                disp('�ع�ͼ����ԭʼͼ����ȫ��ͬ��')
            else
                disp('Warning��ͼ���ع�����')
            end
            %---------------������----------------%
            if check1 == 1 && check2 == 1
                bpp = bpp_BOWS2OrigEp3(i);
                disp(['Embedding capacity equal to : ' num2str(num_emD)])
                disp(['Embedding rate equal to : ' num2str(bpp)])
                fprintf(['�� ',num2str(i),' ��ͼ��-------- OK','\n\n']);
            else
                if check1 ~= 1 && check2 == 1
                    bpp_BOWS2OrigEp3(i) = -2; %��ʾ��ȡ���ݲ���ȷ
                elseif check1 == 1 && check2 ~= 1
                    bpp_BOWS2OrigEp3(i) = -3; %��ʾͼ��ָ�����ȷ
                else
                    bpp_BOWS2OrigEp3(i) = -4; %��ʾ��ȡ���ݺͻָ�ͼ�񶼲���ȷ
                end 
                fprintf(['�� ',num2str(i),' ��ͼ��-------- ERROR','\n\n']);
            end  
        else
            num_BOWS2OrigEp3(i) = num_emD;
            bpp_BOWS2OrigEp3(i) = -1; %��ʾ��Ƕ����Ϣ���޷���ȡ
            disp('�޷���ȡȫ��������Ϣ��')
            fprintf(['�� ',num2str(i),' ��ͼ��-------- ERROR','\n\n']);
        end
    else
        num_BOWS2OrigEp3(i) = -1; %��ʾ����Ƕ����Ϣ  
        disp('������Ϣ������Ƕ�����������޷��洢���ݣ�') 
        fprintf(['�� ',num2str(i),' ��ͼ��-------- ERROR','\n\n']);
    end  
end
%% ��������
save('num_BOWS2OrigEp3')
save('bpp_BOWS2OrigEp3')
