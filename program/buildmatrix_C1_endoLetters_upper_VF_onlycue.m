 function buildmatrix_C1_endoLetters_upper_VF_onlycue(subjectid)
%% buildmatrix for equality task + STAIR (cRef = 0.6)
% the origin code was written by Liufang Zhou, 22/12/2015
% the last edition is by luozixi, 20/03/2023

% column01 sequence number

% column02 trial type[cueValidity2*dir2=4]%[task type1: 1-4][task type2:
% 5-8][task type3:9-12][task type4:13-16]

% column03 cue condition [-1=left, 1=right](grating tasks)
          % or   cue location[-1=left, 1=right]letter task)
          
% column04 ref location [-1=left 1=right]
% column05 test location [-1=left 1=right]
% column06 cue validity [-1=test cued，1=ref cued]

% column07 ITI duration [1200~1800ms]
% column08 cue_letter [1 = letter L 字母L, 2 = letter T 字母T] 
% outnumbered letter at the cued side


% column09 test contrast(%)
% column10 test contrast(log)

% column11 response [1=same, -1=different] [1=L,2=T]
% column12 RT

% column13 initial direction staircase
% column14 next step direction staircase

% column15 staircase bottom
% column16 staircase top
% column17 task type [1 = grating presented simultaneously(behavioral trials), 2=grating presented one after the other(ERP trials), 3=grating presented simultaneously(behavioral trials,ISI=1300),4=only cue(ERP trials),5 = LT presented]
% column18 trigger1 = ref location [1=left 2=right] + cue location [1=left 2=right] + task_type [1:5]
% column19 trigger2 = ref location [1=left 2=right] + cue location [1=left 2=right] + task_type [1:5]

%% 以下代码用于程序调试

%     subjectid = 'test';
%     

%% try命令用来防止数据覆盖
try
    filename = ['data/',subjectid,'_paramatrix'];
    load(filename);
    disp('the file already exist!')
catch
    %% parameter setting
    col = 19;
    
    des_cue = [-1 1];
    des_ref = [-1 1];
    cue_validity = [-1 1];
    cue_location = [-1 1];%catch trial 没有中立提示条件
    dir = [-1 1];
    cue_form = [1 2];  %1=L; 2=T
    sta_bot = [0.2920];
    sta_top = [0.9696];
    npcondition = 480; 
    
    %% 1/3试次为光栅（同时）
    [x1,x2,x3] = ndgrid(des_cue,des_ref,dir);                     % a matrix of randomized parameters
    combinedpara = [x1(:),x2(:),x3(:)];                                   % combined together
    
    paramatrix1 = zeros(length(combinedpara(:,1)),col);
    paramatrix1(:,3) = combinedpara(:,1);
    paramatrix1(:,4) = combinedpara(:,2);
    paramatrix1(:,5) = -combinedpara(:,2);
    paramatrix1(:,6) = combinedpara(:,1).*combinedpara(:,2);
    paramatrix1(:,13) = combinedpara(:,3);
    
    paramatrix1 = sortrows(paramatrix1,[4,6]); %依次根据col4  col6的值进行升序排列
    for r1 = 1:size(des_ref,2)               %size(des_cue,2),des-cue的列数
        for j1 = 1:size(cue_validity,2)
            for k1 = 1:size(dir,2)
                index01 = (j1-1)*size(dir,2)+k1;
                index1 = index01+(r1-1)*size(cue_validity,2)*size(dir,2);%index1为实际的第几个trial，[index01:cue_validity*dir=4]
                paramatrix1(index1,2) = index01;
            end
        end
    end
    %提示的位置2*提示的有效性（刺激的位置）2*初始阶梯方向2=12
    

    paramatrix1(:,17) = 1;
    paramatrix1 = repmat(paramatrix1,npcondition/index1,1);               
    
    
       
    %% 1/3试次为光栅(先后）
    [x4,x5,x6] = ndgrid(des_cue,des_ref,dir);                     % a matrix of randomized parameters
    combinedpara = [x4(:),x5(:),x6(:)];                                   % combined together
    
    paramatrix2 = zeros(length(combinedpara(:,1)),col);
    paramatrix2(:,3) = combinedpara(:,1);
    paramatrix2(:,4) = combinedpara(:,2);
    paramatrix2(:,5) = -combinedpara(:,2);
    paramatrix2(:,6) = combinedpara(:,1).*combinedpara(:,2);
    paramatrix2(:,13) = combinedpara(:,3);
    
    paramatrix2 = sortrows(paramatrix2,[4,6]);
    for r2 = 1:size(des_ref,2)               %size(des_cue,2),des-cue的列数
        for j2 = 1:size(cue_validity,2)
            for k2 = 1:size(dir,2)
                index02 = (j2-1)*size(dir,2)+k2;
                index2 = index02+(r2-1)*size(cue_validity,2)*size(dir,2);%index1为实际的第几个trial
                paramatrix2(index2,2) = index02+4;
            end
        end
    end
    %提示的位置2*提示的有效性（刺激的位置）3*初始阶梯方向2=12
    

    paramatrix2(:,17) = 2;
    paramatrix2 = repmat(paramatrix2,npcondition/index2,1);               
    
    %% 1/6试次为光栅（同时,ISI=1300）
    [x7,x8,x9] = ndgrid(des_cue,des_ref,dir);                     % a matrix of randomized parameters
    combinedpara = [x7(:),x8(:),x9(:)];                                   % combined together
    
    paramatrix3 = zeros(length(combinedpara(:,1)),col);
    paramatrix3(:,3) = combinedpara(:,1);
    paramatrix3(:,4) = combinedpara(:,2);
    paramatrix3(:,5) = -combinedpara(:,2);
    paramatrix3(:,6) = combinedpara(:,1).*combinedpara(:,2);
    paramatrix3(:,13) = combinedpara(:,3);
    
    paramatrix3 = sortrows(paramatrix3,[4,6]); %依次根据col4  col6的值进行升序排列
    for r3 = 1:size(des_ref,2)               %size(des_cue,2),des-cue的列数
        for j3 = 1:size(cue_validity,2)
            for k3 = 1:size(dir,2)
                index03 = (j3-1)*size(dir,2)+k3;
                index3 = index03+(r3-1)*size(cue_validity,2)*size(dir,2);%index3为实际的第几个trial，[index03:cue_validity*dir=4]
                paramatrix3(index3,2) = index03+8;
            end
        end
    end
    %提示的位置2*提示的有效性（刺激的位置）2*初始阶梯方向2=12
    
    paramatrix3 = repmat(paramatrix3,1/2*npcondition/index3,1);               
    paramatrix3(:,17) = 3;

       
   
    %% 1/6的试次设置为only cue
     [x10,x11,x12] = ndgrid(des_cue,des_ref,dir);                     % a matrix of randomized parameters
    combinedpara = [x10(:),x11(:),x12(:)];                                   % combined together
    
    paramatrix4 = zeros(length(combinedpara(:,1)),col);
    paramatrix4(:,3) = combinedpara(:,1);
    paramatrix4(:,4) = combinedpara(:,2);
    paramatrix4(:,5) = -combinedpara(:,2);
    paramatrix4(:,6) = combinedpara(:,1).*combinedpara(:,2);
    paramatrix4(:,13) = combinedpara(:,3);
    
    paramatrix4 = sortrows(paramatrix4,[4,6]); %依次根据col4  col6的值进行升序排列
    for r4 = 1:size(des_ref,2)               %size(des_cue,2),des-cue的列数
        for j4 = 1:size(cue_validity,2)
            for k4 = 1:size(dir,2)
                index04 = (j4-1)*size(dir,2)+k4;
                index4 = index04+(r4-1)*size(cue_validity,2)*size(dir,2);%index3为实际的第几个trial，[index03:cue_validity*dir=4]
                paramatrix4(index4,2) = index04+12;
            end
        end
    end
    %提示的位置2*提示的有效性（刺激的位置）2*初始阶梯方向2=12
    
    paramatrix4 = repmat(paramatrix4,1/2*npcondition/index4,1);               
    paramatrix4(:,17) = 4;
  
     paramatrix1234 = [paramatrix1;paramatrix2;paramatrix3;paramatrix4];
    
     for i =1:length(paramatrix1234(:,1))
                paramatrix1234(i,15) = sta_bot;%staircase_bottom(sta_bot,%) 
                paramatrix1234(i,16) = sta_top;%staircase_top(sta_top,%) 
     end
  
    %% 1/3的试次设置为catch trial 判断
    [x13,x14] = ndgrid(cue_form,cue_location);                     % a matrix of randomized parameters
    combinedpara = [x13(:),x14(:)];                                   % combined together
    
    paramatrix5 = zeros(length(combinedpara(:,1)),col);
    paramatrix5(:,17) = 5;
    paramatrix5(:,8) = combinedpara(:,1);
    paramatrix5(:,3) = combinedpara(:,2);

    %不需要阶梯法，试次类别设为0
    paramatrix5(:,2) = 0;
    paramatrix5 = repmat(paramatrix5,npcondition/size(paramatrix5,1),1);
    
    paramatrix = [paramatrix1234;paramatrix5];
    
    matrix = paramatrix; 
    length0 = length(paramatrix);   %行；列 的最大值
    randIndex = randperm(length0);
    for r = 1:length0
        paramatrix(r,:) = matrix(randIndex(r),:);
        ITIdura = round(rand(1)*600+1200); % 1200~1800ms
        paramatrix(r,7) = round(ITIdura);
    end                             % 乱序
    
  
    paramatrix(:,1) = 1:length(paramatrix(:,1));

    paramatrix(:,18) = (paramatrix(:,4)+3)./2.*100+(paramatrix(:,3)+3)./2.*10+paramatrix(:,17);%trigger1
    paramatrix(:,19) = (paramatrix(:,4)+3)./2.*100+(paramatrix(:,3)+3)./2.*10+paramatrix(:,17)+5;%trigger2
    
    
    %% save
    filename = ['data/',subjectid,'_paramatrix'];
    save(filename,'paramatrix');
    clear
    
end
end

