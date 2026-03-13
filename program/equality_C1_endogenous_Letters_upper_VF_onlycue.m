function equality_C1_endogenous_Letters_upper_VF_onlycue(subjectid,start,over,blockNum)
%%  equality + stair (cRef = 0.6)
 
% last modification 20/03/2023 by luozixi
% this is presumly the last edition for C1(stimuli in the upper VF)adopted
% adopting Pan C1 exogeneous stimulus size and location

global inc background white
%% %%%%%%%%%%%%%%%%%%%%%%%%%% 定义屏幕 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
HideCursor;
% Screen('Preference', 'SkipSyncTests', 1);   %正式实验中注释掉
screenNumber=max(Screen('Screens'));
block_num = 0;%计算当前是第几个block

% 屏幕颜色
white=WhiteIndex(screenNumber);
black=BlackIndex(screenNumber);
grey=round((white+black)/2);
if grey == white
    grey=white / 2;
end
inc = abs(white-grey);
background=grey;

% 打开一个屏幕
[w,rect]=Screen('OpenWindow',screenNumber,background);

% 屏幕属性设定
AssertGLSL;                                                                 % Make sure this GPU supports shading at all
% load('newclut');
% load('oldclut');
% Screen('LoadNormalizedGammaTable',screenNumber,newclut);                    % write CLUTs, screen normalization
Screen(w,'BlendFunction',GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);             % Enable alpha blending for typical drawing of masked textures
priorityLevel=MaxPriority(w);
Priority(priorityLevel);

% 屏幕刷新频率
frameRate=Screen('FrameRate',w);
frameDura=1000/frameRate;
if  round(frameRate)~=100                                                   % 确保刷新频率是100hz程序才能运行,调试的时候注释
    quit
end

% frameDura = 10;%cnm，程序调试，正式试验时须改回检验
% 屏幕尺寸
xcenter=rect(3)/2;                                                          % 屏幕中心横坐标
ycenter=rect(4)/2;


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%% 定义反应按键 %%%%%%%%%%%%%%%%%%%%%%%%%%%
KbName('UnifyKeyNames');
key_s=KbName('s');%F键一样，d键不一样;
key_d=KbName('d');%F键一样，d键不一样;

key_left=KbName('LeftArrow');         %字母L
key_right=KbName('RightArrow');       %字母T

key_p=KbName('p');
space=KbName('space');


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%% 刺激参数设定 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% size
% 刺激大小 
pixelPerDegree = round(degree2pixel(1));

r = 1.5;
sizeGrating = round(degree2pixel(r));  % 刺激的半径

LetterSize = round(degree2pixel(0.36)); %字母半径0.36

gap_size = round(degree2pixel(2.5)); %半径

%% fixation,两条线段组成
Line_width = round(degree2pixel(0.1));
Line_length_h = round(degree2pixel(0.36));
Line_length_v = round(degree2pixel(0.18));
Line_rect = CenterRect([0 0 Line_length_h Line_length_v],rect);
Line_fixation_left = [Line_rect(1) Line_rect(2) Line_rect(3) Line_rect(4)];
Line_fixation_right=[Line_rect(3) Line_rect(2) Line_rect(1) Line_rect(4)];

%% color
FixationColor = black;
CueColor = white;



%% destinations
% gratings % 1 左 2 右
eccentricity_h = round(degree2pixel(3.6));
eccentricity_v = round(degree2pixel(1.8));
desCenter(:,:,1) = [xcenter-eccentricity_h-sizeGrating ycenter-eccentricity_v-sizeGrating...
    xcenter-eccentricity_h+sizeGrating ycenter-eccentricity_v+sizeGrating]; % left
desCenter(:,:,2) = [xcenter+eccentricity_h-sizeGrating ycenter-eccentricity_v-sizeGrating...
    xcenter+eccentricity_h+sizeGrating ycenter-eccentricity_v+sizeGrating]; % right

%% 提示坐标计算
%left
Cue_rect(1,:) = [Line_rect(1) Line_rect(2) xcenter ycenter];
%right
Cue_rect(2,:) = [Line_rect(3) Line_rect(2) xcenter ycenter];

%% Letters 坐标 
%左边的5个位置
des_Large_Letters(:,:,1) = [xcenter-eccentricity_h-LetterSize ycenter-eccentricity_v-LetterSize-gap_size...
    xcenter-eccentricity_h+LetterSize ycenter-eccentricity_v+LetterSize-gap_size]; % left_top

des_Large_Letters(:,:,3) = [xcenter-eccentricity_h-LetterSize-gap_size ycenter-eccentricity_v-LetterSize...
    xcenter-eccentricity_h+LetterSize-gap_size ycenter-eccentricity_v+LetterSize]; % left_left

des_Large_Letters(:,:,5) = [xcenter-eccentricity_h-LetterSize ycenter-eccentricity_v-LetterSize+gap_size...
    xcenter-eccentricity_h+LetterSize ycenter-eccentricity_v+LetterSize+gap_size]; % left_bottom

des_Large_Letters(:,:,7) = [xcenter-eccentricity_h-LetterSize+gap_size ycenter-eccentricity_v-LetterSize...
    xcenter-eccentricity_h+LetterSize+gap_size ycenter-eccentricity_v+LetterSize]; % left_right

des_Large_Letters(:,:,9) = [xcenter-eccentricity_h-LetterSize ycenter-eccentricity_v-LetterSize...
    xcenter-eccentricity_h+LetterSize ycenter-eccentricity_v+LetterSize];  %left_middle

%右边的5个位置
des_Large_Letters(:,:,2) = [xcenter+eccentricity_h-LetterSize ycenter-eccentricity_v-LetterSize-gap_size...
    xcenter+eccentricity_h+LetterSize ycenter-eccentricity_v+LetterSize-gap_size]; % right_top

des_Large_Letters(:,:,4) = [xcenter+eccentricity_h-LetterSize+gap_size ycenter-eccentricity_v-LetterSize...
    xcenter+eccentricity_h+LetterSize+gap_size ycenter-eccentricity_v+LetterSize]; % right_right

des_Large_Letters(:,:,6) = [xcenter+eccentricity_h-LetterSize ycenter-eccentricity_v-LetterSize+gap_size...
    xcenter+eccentricity_h+LetterSize ycenter-eccentricity_v+LetterSize+gap_size]; % right_bottom

des_Large_Letters(:,:,8) = [xcenter+eccentricity_h-LetterSize-gap_size ycenter-eccentricity_v-LetterSize...
    xcenter+eccentricity_h+LetterSize-gap_size ycenter-eccentricity_v+LetterSize]; % right_left

des_Large_Letters(:,:,10) = [xcenter+eccentricity_h-LetterSize ycenter-eccentricity_v-LetterSize...
    xcenter+eccentricity_h+LetterSize ycenter-eccentricity_v+LetterSize];        %right_middle
%% durations
% fixation
fixDura = 400;
fixFrames = round(fixDura/frameDura);

% cue
cueDura = 400;
cueFrames = round(cueDura/frameDura);
half_cueFrames=round((1+cueFrames)/2); 
%%cosine  time window
Cue_ramptime=200;
Cue_rampwidth=(Cue_ramptime/frameDura);
CueTimePoints=1:cueFrames; %frame 点
CenterPoint=round((1+cueFrames)/2); %时间窗的中心点
time_maskMatrix1 = cos(2*pi/Cue_rampwidth*(half_cueFrames-sqrt((CueTimePoints-CenterPoint).^2))+pi)/2+1/2;%cosine函数包裹
time_maskMatrix2 = sign(sign((half_cueFrames).^2-(CueTimePoints-CenterPoint).^2)+1);%在半径为cue时间一半的圆外则为0，在圆上或者圆内则为1的mask
time_maskMatrix3 = sign(sign(-(half_cueFrames-Cue_rampwidth/2).^2+(CueTimePoints-CenterPoint).^2)+1);%在consine包裹和圆区间内为1，中间平台为0的mask
time_maskMatrix4 = sign(sign((half_cueFrames-Cue_rampwidth/2).^2-(CueTimePoints-CenterPoint).^2)+1); %在内部平台上及边缘为1，外面为0
time_maskMatrix = min(time_maskMatrix1.*time_maskMatrix2.*time_maskMatrix3+time_maskMatrix4,1);
Cue_timewindow=CueTimePoints.*time_maskMatrix;

% ISI1
blankDura = 1000; 
blankFrames = round(blankDura/frameDura);    

% gratingDura
gratingDura = 50;
gratingFrames = round(gratingDura/frameDura);

% ISI2
gratingBetweenDura = 250;
gratingBetweenFrames = round(gratingBetweenDura/frameDura);

% Catch trial duration
CatchDura = 190;   %大注意范围时间为190ms
CatchFrames = round(CatchDura/frameDura);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%% grating %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% 空间频率spatial frequency
cyclePerDegree = 4;
period = pixelPerDegree/cyclePerDegree; % how many pixels in one cycle
sf = 1/period;
angleRef = 0;
angleTest = 0;


%% ----------ERP：初始化打码端口----------
ioObj = io64;
status = io64(ioObj);
address = hex2dec('3FF0'); %standard LPT1 output port address


%% %%%%%%%%%%%%%%%%%%%% letter相关参数 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%%%%%%%%%%%%%%%% eye tracking setup %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %% eye tracker setup
% %%启动之前初始化串口（关闭 删除可能存在的串口）
%  IOPort('closeall');
% %
% % %%启动串口
% %  [handle, errmsg] = IOPort('OpenSerialPort', 'com4' ,'BaudRate=256000 ReceiveTimeout=0.3');
%  [handle, errmsg] = IOPort('OpenSerialPort', 'com9','BaudRate=115200 ReceiveTimeout=0.2'); %com数字和BauRate的数字对应主程序的电脑的COM端口和波特率
% IOPort('Purge',handle); %清除所有读写缓冲区数据
% % %%%%%%%%%%
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%1 发送StimRD（stimuli ready）信号 刺激呈现已准备好
%  StimRD='R';
%  [nwritten, when, errmsg] = IOPort('Write', handle, StimRD);
% 
% % %%2 接收Tobii发来的准备好信号
% while KbCheck; end
%   TobReSig=0;
%   qkey=KbName('q');
%   keycode=zeros(1,256);
%   while ~keycode(qkey) && ~TobReSig
%       [data, when, errmsg] = IOPort('Read', handle,0,1);
%       IOPort('Purge',handle); %清除所有读写缓冲区数据
%       tobiiready=char(data);
%       [keydown secs keycode]=KbCheck;
% %
%       if strcmp(tobiiready,'R')==1
%           fprintf('Tobii is ready! \n');
%           fprintf('------------------------------------------\n');
%           TobReSig=1;
%       else
%           [nwritten, when, errmsg] = IOPort('Write', handle, StimRD);
%           fprintf('%f Waiting for Tobii getting ready. \n', when);
%           WaitSecs(1);
%       end
%   end



%% %%%%%%%%%%%%%%%%%%%%%%%  导入buildmatrix %%%%%%%%%%%%%%%%%%%%%%%%%
filename = ['data/',subjectid,'_paramatrix'];
load(filename);

% number of trials/per block;
npblock = length(paramatrix(:,1))/blockNum;

%%%%%%%%%%%%%%%%%%%%%%%%%% 导入字母图片%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load Lmatrix;  %调入需要呈现的图形像素矩阵，数字L
load Tmatrix;  %调入需要呈现的图形像素矩阵，数字T

ContrastLetter=0.5;

LMatrix=(LMatrix/255)*background; %把字母L矩阵的白色背景的灰度值设置为屏幕灰色背景
LMatrix(find(LMatrix==0))=[ContrastLetter*background]; %调节字母的对比度
TMatrix=(TMatrix/255)*background; %把字母T矩阵的白色背景的灰度值设置为屏幕灰色背景
TMatrix(find(TMatrix==0))=[ContrastLetter*background];
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%% 循环结构 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Screen('Flip',w); % 提高精度
        WaitSecs(0.5);
        [keyisdown,secs,keycode] = KbCheck;
       while keycode(space) == 0
            KbWait;
            [keyisdown,secs,keycode] = KbCheck;
            WaitSecs(0.001);
            
            % 按p键退出
            if keycode(key_p)
                ShowCursor;
                Priority(0);
                %Screen('LoadNormalizedGammaTable',screenNumber,oldclut);
                Screen('CloseAll');
%                             ExpOver='O';
%                             [nwritten, when, errmsg] = IOPort('Write', handle, ExpOver);
%                             fprintf('%f Experiment Over!!！ \n',when);
%                             IOPort('closeall');
                ShowCursor; %
                return
            end
        end

for index = start:over
    
   % 光栅对比度
  cRef = 0.6;
  minc = paramatrix(index,15);
  maxc = paramatrix(index,16);
  cTest0 = [minc maxc];
  stepdir0 = [1 -1];
  phase = rand(1)*2*pi;
    
    trialtype = paramatrix(index,2); % cue validity*direction staircase*task type
    initialdir = mod(trialtype,2)+1;
    
    indexDesCue = (paramatrix(index,3)+3)/2; %-1 1→1 2
    indexDesRef = (paramatrix(index,4)+3)/2;%-1 1→1 2
    indexDesTest = (paramatrix(index,5)+3)/2; %-1 1→1 2
    
    indexTaskType = paramatrix(index,17);
    ITIDura = paramatrix(index,7);
    ITIFrames = round(ITIDura/frameDura);
     % 脑电字符
    trigger1 = paramatrix(index,18);
    trigger2 = paramatrix(index,19);
    
    if indexTaskType ~= 5 % not catch trial
        indexMatrix = paramatrix(find(paramatrix(:,2)==trialtype),1); % 得到该trialtype的trial序列号
        % the first trial
        if paramatrix(indexMatrix,9)==0 % test contrast matrix
            paramatrix(index,9) = cTest0(initialdir);
            paramatrix(index,10) = log(cTest0(initialdir)*100);
            paramatrix(index,14) = stepdir0(initialdir);
        end
        
        cTest = paramatrix(index,9);
        
        MatrixTest = TextureCenter(sizeGrating,angleTest,cTest,sf,phase);
        test = Screen('MakeTexture',w, MatrixTest);
        MatrixRef = TextureCenter(sizeGrating,angleRef,cRef,sf,phase);
        ref = Screen('MakeTexture',w, MatrixRef);
        nongrating = Screen('MakeTexture',w,[background]);
        if indexTaskType == 1
        gratingTexture1 = [test ref];
        gratingTexture2 = [nongrating nongrating];
        elseif indexTaskType == 2
        gratingTexture1 = [nongrating ref];
        gratingTexture2 = [test nongrating];
        elseif indexTaskType == 3
        gratingTexture2 = [test ref];
        gratingTexture1 = [nongrating nongrating];
        else
        gratingTexture1 = [nongrating nongrating];
        gratingTexture2 = [nongrating nongrating];
        end
        
        desGrating = reshape([desCenter(:,:,indexDesTest) desCenter(:,:,indexDesRef)],4,2);
         Screen('Flip', w);
        %% %%%%%%%%%%%%%%%%%% 呈现注视点，等待被试按下空格键开始呈现 %%%%%%%%%%%%%%%%%
%         Screen('FillRect',w,WaitColor,[Line_Vertical_rect',Line_Horizental_rect']);
       
        
%             %%3 发送StaRec信号，要求眼动仪开始记录眼动数据
%             StartRecord='B';
%             [nwritten, when, errmsg] = IOPort('Write', handle, StartRecord);
%             fprintf('Trial %i.\n',index);
%             fprintf('%f Ask Tobii to begin to record. \n',when);
%         
%             %%4 呈现刺激
%             fprintf('Presenting Stimuli ....... \n');
        
%         按空格开始
%         if keycode(space)
             % 0. 试次开始前的ITI
             
             for r = 1:ITIFrames
                 Screen('Flip',w);
             end
            
            
            
            % 1. 注视点呈现
           
            for r = 1:fixFrames
                Screen('DrawLine',w,FixationColor,Line_fixation_left(1),Line_fixation_left(2),Line_fixation_left(3),Line_fixation_left(4),Line_width);
                Screen('DrawLine',w,FixationColor,Line_fixation_right(1),Line_fixation_right(2),Line_fixation_right(3),Line_fixation_right(4),Line_width);
                Screen('Flip',w);
            end
           
            
            % 2. cue呈现
            
            for r = 1:cueFrames
                Screen('DrawLine',w,FixationColor,Line_fixation_left(1),Line_fixation_left(2),Line_fixation_left(3),Line_fixation_left(4),Line_width);
                Screen('DrawLine',w,FixationColor,Line_fixation_right(1),Line_fixation_right(2),Line_fixation_right(3),Line_fixation_right(4),Line_width);
                Screen('DrawLine',w,Cue_timewindow(r)*CueColor, Cue_rect(indexDesCue,1),Cue_rect(indexDesCue,2),Cue_rect(indexDesCue,3),Cue_rect(indexDesCue,4),Line_width);%提示点
                Screen('Flip', w);
            end
            
            io64(ioObj, address, trigger1);
            % 3. ISI1
            
            for r = 1:blankFrames
                Screen('DrawLine',w,FixationColor,Line_fixation_left(1),Line_fixation_left(2),Line_fixation_left(3),Line_fixation_left(4),Line_width);
                Screen('DrawLine',w,FixationColor,Line_fixation_right(1),Line_fixation_right(2),Line_fixation_right(3),Line_fixation_right(4),Line_width);
                Screen('Flip',w);
            end
            
            
            
            % 4. pre刺激呈现
            
            for r = 1: gratingFrames
                Screen('DrawTextures',w,gratingTexture1,[],desGrating); % gratings
                Screen('DrawLine',w,FixationColor,Line_fixation_left(1),Line_fixation_left(2),Line_fixation_left(3),Line_fixation_left(4),Line_width);
                Screen('DrawLine',w,FixationColor,Line_fixation_right(1),Line_fixation_right(2),Line_fixation_right(3),Line_fixation_right(4),Line_width);
                start_time = Screen('Flip',w);
                if r==1
                    io64(ioObj, address, trigger2);
                end
            end
              %%%%%ERP:打码初始化%%%%
           io64(ioObj, address, 0);  %%初始为0 
            
            
    if indexTaskType == 2|| indexTaskType == 3 || indexTaskType == 4%任务一在第一次呈现光栅后即可反应
              % 5. ISI2
            
            for r = 1:gratingBetweenFrames
               Screen('DrawLine',w,FixationColor,Line_fixation_left(1),Line_fixation_left(2),Line_fixation_left(3),Line_fixation_left(4),Line_width);
                Screen('DrawLine',w,FixationColor,Line_fixation_right(1),Line_fixation_right(2),Line_fixation_right(3),Line_fixation_right(4),Line_width);
                Screen('Flip',w);
            end
          
            
             % 6. post刺激呈现
            
            for r = 1: gratingFrames
                Screen('DrawTextures',w,gratingTexture2,[],desGrating); % gratings
                  Screen('DrawLine',w,FixationColor,Line_fixation_left(1),Line_fixation_left(2),Line_fixation_left(3),Line_fixation_left(4),Line_width);
                Screen('DrawLine',w,FixationColor,Line_fixation_right(1),Line_fixation_right(2),Line_fixation_right(3),Line_fixation_right(4),Line_width);
                start_time = Screen('Flip',w);
            end
            
    end
%         end
        
%             %%5 Tobii 停止记录
%             StopRecord='S';
%             [nwritten, when, errmsg] = IOPort('Write', handle, StopRecord);
%             fprintf('%f Ask Tobii to stop recording. \n',when);
        
        %% %%%%%%%%%%%%%%%%%%%%%%%%% 记录反应 保存结果%%%%%%%%%%%%%%%%%%%%%%%%%%
       
            Screen('DrawLine',w,FixationColor,Line_fixation_left(1),Line_fixation_left(2),Line_fixation_left(3),Line_fixation_left(4),Line_width);
            Screen('DrawLine',w,FixationColor,Line_fixation_right(1),Line_fixation_right(2),Line_fixation_right(3),Line_fixation_right(4),Line_width);
            Screen('Flip',w);
             
        
     if indexTaskType~=4 %任务四无需进行反应 
           %%%%%%%
            key = 0;
        
        while key == 0
            
            % 反应记录
            [keyisdown, secs, keycode] =  KbCheck;
            over_time=GetSecs;
            WaitSecs(0.001);
            paramatrix(index,12) = (over_time-start_time)*1000;
            
            if keycode(key_d)
                
                key = 1;
                
                paramatrix(index,11) = -1;                                        %different response
                trigger3 = 2;  %same = 1 ; different = 2
                break
            elseif keycode(key_s)
                key = 1;
                paramatrix(index,11) = 1;                                       % same  response
                trigger3 = 1;  %same = 1 ; different = 2
                break
            elseif keycode(key_p)
                Priority(0);
%                 Screen('LoadNormalizedGammaTable',screenNumber,oldclut);
                Screen('CloseAll');
                %             ExpOver='O';
                %             [nwritten, when, errmsg] = IOPort('Write', handle, ExpOver);
                %             fprintf('%f Experiment Over!!！ \n',when);
                %             IOPort('closeall');
                ShowCursor; %
                return
            end
        end
        Screen('Flip',w);
        io64(ioObj, address, trigger3);
        %% beep
%         if beep == true
%             if round(cRef*100) == round(cTest*100)
%                 if paramatrix(index,11)==-1
%                     Beeper(800);
%                 end
%             elseif round(cTest*100)<=47 || round(cTest*100)>=76
%                 if  paramatrix(index,11)==1
%                     Beeper(400);
%                 end
%             end
%         end
        %% %% next trial %%%
        
        contrastMatrix = paramatrix(indexMatrix,9);
        responseMatrix = paramatrix(indexMatrix,11);
        dirMatrix = paramatrix(indexMatrix,14);
        [cTest2,stepdir2] = equalitystair(contrastMatrix,responseMatrix,dirMatrix,minc,maxc,cTest0(initialdir));
        index1=length(find(contrastMatrix~=0));      %当前的trial序号（即最后一个强度不为0的trial）
        if index1 < size(contrastMatrix,1)
            index2 = indexMatrix(index1+1);              % next sequence index of this type
            paramatrix(index2,9) = cTest2;
            paramatrix(index2,10) = log(cTest2*100);
            paramatrix(index2,14) = stepdir2;
        end
     else
        paramatrix(index,11) = 0;
     end
        Screen('close',gratingTexture1);                                         % close screen
         Screen('close',gratingTexture2);                                         % close screen

        %% % catch trial
    elseif indexTaskType  == 5
        indexDesCue = (paramatrix(index,3)+3)/2;  % 1 2 
        indexDesCueLetter = indexDesCue; %1 2 
        indexDesNotCueLetter = 3-indexDesCue;  % 2 1
        letter = paramatrix(index,8);  %cue_letter 1L 2T  提示位置的letter
        noletter = round(rand(1)+1);%未被提示位置的letter随机，可能是L也可能是T
     
       
        indexDesCueLetter1=indexDesCueLetter;
        indexDesCueLetter2=indexDesCueLetter+2;
        indexDesCueLetter3=indexDesCueLetter+4;
        indexDesCueLetter4=indexDesCueLetter+6;
        indexDesCueLetter5=indexDesCueLetter+8;
        
        indexDesNotCueLetter1=indexDesNotCueLetter;
        indexDesNotCueLetter2=indexDesNotCueLetter+2;
        indexDesNotCueLetter3=indexDesNotCueLetter+4;
        indexDesNotCueLetter4=indexDesNotCueLetter+6;
        indexDesNotCueLetter5=indexDesNotCueLetter+8;
        
            
            if letter == 2                      %提示一侧更多的字母是T
               CueLessLetter=LMatrix;
               CueMoreLetter=TMatrix;
            
            elseif letter == 1                  %提示一侧更多的字母是L
               CueLessLetter=TMatrix;
               CueMoreLetter=LMatrix;
        
            end  
       
           if noletter == 2                     %不被提示一侧更多的字母是T
              NotCueLessLetter=LMatrix;
              NotCueMoreLetter=TMatrix;
              
           elseif noletter == 1                %不被提示一侧更多的字母是L
              NotCueLessLetter=TMatrix;
              NotCueMoreLetter=LMatrix;
    
           end
       
       CueLessTexture1 = Screen('MakeTexture',w, CueLessLetter);
       CueLessTexture2 = Screen('MakeTexture',w, CueLessLetter);
       CueMoreTexture1 = Screen('MakeTexture',w, CueMoreLetter);
       CueMoreTexture2 = Screen('MakeTexture',w, CueMoreLetter);
       CueMoreTexture3 = Screen('MakeTexture',w, CueMoreLetter);
       
       NotCueLessTexture1= Screen('MakeTexture',w, NotCueLessLetter);
       NotCueLessTexture2= Screen('MakeTexture',w, NotCueLessLetter);
       NotCueMoreTexture1= Screen('MakeTexture',w, NotCueMoreLetter);     
       NotCueMoreTexture2= Screen('MakeTexture',w, NotCueMoreLetter); 
       NotCueMoreTexture3= Screen('MakeTexture',w, NotCueMoreLetter); 
       
       CueLetterTexture0=[CueLessTexture1 CueLessTexture2 CueMoreTexture1 CueMoreTexture2 CueMoreTexture3];
       C0=randperm(size(CueLetterTexture0,2));  
       CueLetterTexture=CueLetterTexture0(:, C0);  
       
       NotCueLetterTexture0=[NotCueLessTexture1 NotCueLessTexture2 NotCueMoreTexture1 NotCueMoreTexture2 NotCueMoreTexture3];
       N0=randperm(size(NotCueLetterTexture0,2));  
       NotCueLetterTexture=NotCueLetterTexture0(:, N0);  
       
       LetterTexture = [CueLetterTexture NotCueLetterTexture];
       TrialdesLetter =  reshape([des_Large_Letters(:,:,indexDesCueLetter1) des_Large_Letters(:,:,indexDesCueLetter2) des_Large_Letters(:,:,indexDesCueLetter3) des_Large_Letters(:,:,indexDesCueLetter4) des_Large_Letters(:,:,indexDesCueLetter5) des_Large_Letters(:,:,indexDesNotCueLetter1) des_Large_Letters(:,:,indexDesNotCueLetter2) des_Large_Letters(:,:,indexDesNotCueLetter3) des_Large_Letters(:,:,indexDesNotCueLetter4) des_Large_Letters(:,:,indexDesNotCueLetter5)],4,10);        
       
        %% %%%%%%%%%%%%%%%%%% 呈现注视点，等待被试按下空格键开始呈现 %%%%%%%%%%%%%%%%%
%         Screen('FillRect',w,WaitColor,[Line_Vertical_rect',Line_Horizental_rect']);
          Screen('Flip', w);
%         WaitSecs(0.5);
%         [keyisdown,secs,keycode] = KbCheck;
%         while keycode(space) == 0
%             KbWait;
%             [keyisdown,secs,keycode] = KbCheck;
%             WaitSecs(0.001);
%             
%             % 按q键退出
%             if keycode(key_p)
%                 ShowCursor;
%                 Priority(0);
%                              Screen('LoadNormalizedGammaTable',screenNumber,oldclut);
%                 Screen('CloseAll');
% %                             ExpOver='O';
% %                             [nwritten, when, errmsg] = IOPort('Write', handle, ExpOver);
% %                             fprintf('%f Experiment Over!!！ \n',when);
% %                             IOPort('closeall');
%                 ShowCursor; %
%                 return
%             end
%         end
        
%             %%3 发送StaRec信号，要求眼动仪开始记录眼动数据
%             StartRecord='B';
%             [nwritten, when, errmsg] = IOPort('Write', handle, StartRecord);
%             fprintf('Trial %i.\n',index);
%             fprintf('%f Ask Tobii to begin to record. \n',when);
%         
%             %%4 呈现刺激
%             fprintf('Presenting Stimuli ....... \n');
        
        % 按空格开始
%         if keycode(space)
            
          % 0. 试次开始前的ITI
            for r = 1:ITIFrames
                Screen('Flip',w);
            end


            % 1. 注视点呈现
            for r = 1:fixFrames
                Screen('DrawLine',w,FixationColor,Line_fixation_left(1),Line_fixation_left(2),Line_fixation_left(3),Line_fixation_left(4),Line_width);
                Screen('DrawLine',w,FixationColor,Line_fixation_right(1),Line_fixation_right(2),Line_fixation_right(3),Line_fixation_right(4),Line_width);
                Screen('Flip',w);
            end
            
            
            % 2. cue呈现
            for r = 1:cueFrames
                 Screen('DrawLine',w,FixationColor,Line_fixation_left(1),Line_fixation_left(2),Line_fixation_left(3),Line_fixation_left(4),Line_width);
                Screen('DrawLine',w,FixationColor,Line_fixation_right(1),Line_fixation_right(2),Line_fixation_right(3),Line_fixation_right(4),Line_width);
                Screen('DrawLine',w,Cue_timewindow(r)*CueColor, Cue_rect(indexDesCue,1),Cue_rect(indexDesCue,2),Cue_rect(indexDesCue,3),Cue_rect(indexDesCue,4),Line_width);%提示点
                Screen('Flip', w);
            end
             io64(ioObj, address, trigger1);
            % 3. ISI1
            for r = 1:blankFrames
                 Screen('DrawLine',w,FixationColor,Line_fixation_left(1),Line_fixation_left(2),Line_fixation_left(3),Line_fixation_left(4),Line_width);
                Screen('DrawLine',w,FixationColor,Line_fixation_right(1),Line_fixation_right(2),Line_fixation_right(3),Line_fixation_right(4),Line_width);
                Screen('Flip',w);
            end
             
            % 4. catch trial刺激呈现
             
            for r = 1: CatchFrames
                 Screen('DrawLine',w,FixationColor,Line_fixation_left(1),Line_fixation_left(2),Line_fixation_left(3),Line_fixation_left(4),Line_width);
                Screen('DrawLine',w,FixationColor,Line_fixation_right(1),Line_fixation_right(2),Line_fixation_right(3),Line_fixation_right(4),Line_width);
                Screen('DrawTextures',w,LetterTexture,[],TrialdesLetter); % letters
                start_time = Screen('Flip',w);
                if r==1
                    io64(ioObj, address, trigger2);
                end
            end
               %%%%%ERP:打码初始化%%%%
           io64(ioObj, address, 0);  %%初始为0
%         end
        
%             %%5 Tobii 停止记录
%             StopRecord='S';
%             [nwritten, when, errmsg] = IOPort('Write', handle, StopRecord);
%             fprintf('%f Ask Tobii to stop recording. \n',when);
        
        %% %%%%%%%%%%%%%%%%%%%%%%%%% 记录反应 保存结果%%%%%%%%%%%%%%%%%%%%%%%%%%
  
              Screen('DrawLine',w,FixationColor,Line_fixation_left(1),Line_fixation_left(2),Line_fixation_left(3),Line_fixation_left(4),Line_width);
              Screen('DrawLine',w,FixationColor,Line_fixation_right(1),Line_fixation_right(2),Line_fixation_right(3),Line_fixation_right(4),Line_width);
              Screen('Flip',w);
         
           %%%%%%% 
            
         key = 0;
         
        while key == 0
            % 反应记录
            [keyisdown, secs, keycode] =  KbCheck;
            over_time=GetSecs;
            WaitSecs(0.001);
            paramatrix(index,12) = (over_time-start_time)*1000;
            
            if keycode(key_left)
                key = 1;
                paramatrix(index,11) = 1;                                        % letter L
                 trigger3 = 3;  %L = 3; T = 4
                break
            elseif keycode(key_right)
                key = 1;
                paramatrix(index,11) = 2;                                       % letter T
                 trigger3 = 4;  %L = 3; T = 4 
                break
            elseif keycode(key_p)
                Priority(0);
%                 Screen('LoadNormalizedGammaTable',screenNumber,oldclut);
                Screen('CloseAll');
                %             ExpOver='O';
                %             [nwritten, when, errmsg] = IOPort('Write', handle, ExpOver);
                %             fprintf('%f Experiment Over!!！ \n',when);
                %             IOPort('closeall');
                ShowCursor; %
                return
            end
        end
        Screen('close',LetterTexture);                                         % close screen
       Screen('Flip',w);
       io64(ioObj, address, trigger3);
        %% beep
%         if beep == true
            if paramatrix(index,11)~=paramatrix(index,8)%说明判断出错
                Beeper(800);
            end
%         end
    end
    
%         %%6接收眼动仪数据
%         fprintf('%f Receiving data .......\n',when);
%         XYPositionTimepoint=ReceiveEyemoveData(handle);
%         PositionTime{index}=XYPositionTimepoint;
%         save(['fixData/',subjectid,'_FixData'],'PositionTime','rect')
%         % WaitSecs(1);
%         fprintf('------------------------------------------\n');
    
    %% save
    save(filename,'paramatrix');
    
    % 休息
    if mod(index,npblock)==0 && index~=over
        block_num = block_num+1;
        text_rest = strcat('Take A Rest. Block num = ',num2str(block_num))
        Screen('DrawText',w,text_rest,xcenter-80,ycenter, [0 0 0]);
        Screen('Flip',w);
        WaitSecs(5);%rest for 90s
        KbWait;
    elseif index==over
%                 ExpOver='O';
%                 [nwritten, when, errmsg] = IOPort('Write', handle, ExpOver);
%                 fprintf('%f Experiment Over!!！ \n',when);
%                 IOPort('closeall');
        
        Screen('DrawText',w,'The end. Thank You! ',xcenter-150,ycenter, [0 0 0]);
        Screen('Flip',w);
        WaitSecs(1);
        KbWait;
        break
    end
       %%%%%ERP:打码初始化%%%%
       io64(ioObj, address, 0);  %%初始为0
       %%%%%%%
end

%% %%%%%%%%%%%%%%%%%%%%%% 关闭窗口%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Priority(0);
%  Screen('LoadNormalizedGammaTable',screenNumber,oldclut);
Screen('CloseAll');
ShowCursor; % 显示鼠标

end









