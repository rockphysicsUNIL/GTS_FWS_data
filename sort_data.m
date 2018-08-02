clear all
clc

% Depth positions of Static FWS measurements [dm]
pos=[52 58 64 70 76 82 88 94 100 198 204 210 216 222 228 234 240 246 252 ...
    258 264 270 400 403 406 409 412 415 418 421 424 427 430];   


%% for config 1
% nsam=525;   % number of samples
% config='s'; % probe configuration s:short, l2:long
%% for config 2
nsam=518;   % number of samples
config='l2'; % probe configuration s:short, l2:long


freq=sprintf('%s','3'); % frequency

real_depth=[];
counter=1;
for i=1:length(pos)
% Name of static files: "static_freckHz_position_config"
if pos(i)<100
position=sprintf('%s%i','0',pos(i));  %add zero to the position for the file name
else
position=sprintf('%i',pos(i));  %do nothing
end

filename= sprintf('%s','static_',freq,'kHz_',position,'dm_',config,'.txt');  %file name to find  

if exist(filename, 'file')==2  %check if the file exists
REC1=[];REC2=[];REC3=[];
 
% a=load(filename);  %load file if exists

fileID=fopen(filename);
header1= fgetl(fileID); %skip first lines
header2= fgetl(fileID); %skip first lines


f1=fscanf(fileID,'%f',[1,1])+1;  %auxiliar for reading file and assign repetitions
while f1>0
%read line by line each receiver in order REC1, REC2, REC3    
REC1(f1,:)=fscanf(fileID,'%f',[1,nsam]);  
REC2(f1,:)=fscanf(fileID,'%f',[1,nsam]);   
REC3(f1,:)=fscanf(fileID,'%f',[1,nsam]);   

f1=fscanf(fileID,'%f',[1,1])+1;
end
fclose(fileID);
% save_file = sprintf('%s','static_',freq,'kHz_',position,'dm_',config,'.mat');  %file name to find
% save(save_file,'REC1','REC2','REC3');


% Compute stack of repetition
REC1_stack=mean(REC1);
REC2_stack=mean(REC2);
REC3_stack=mean(REC3);

real_depth(counter)=pos(i);

% Array with RECs as function of depth
REC1_depth(counter,:)=REC1_stack;
REC2_depth(counter,:)=REC2_stack;
REC3_depth(counter,:)=REC3_stack;

counter=counter+1;
end
    
end
% save_file = sprintf('%s','static_',freq,'kHz_',config,'.mat');  %file name to find  
% save(save_file,'REC1_depth','REC2_depth','REC3_depth','real_depth');



% scaling=500;
% for i=1:length(pos)
%     subplot(1,3,1)
%     hold on
%     plot(1/scaling*REC1_depth(i,:)+pos(i))
%     hold off
%     
%     subplot(1,3,2)
%     hold on
%     plot(1/scaling*REC2_depth(i,:)+pos(i))
%     hold off
%     
%     subplot(1,3,3)
%     hold on
%     plot(1/scaling*REC3_depth(i,:)+pos(i))
%     hold off
% end
% 
% ax1=subplot(1,3,1)
% axis ij
% xlabel('time [\mus]')
% ylabel('depth[dm]')
% set(gca,'Xtick',[0:100:500],'XTickLabel',[0:100:500]*4)
% 
% ax2=subplot(1,3,2)
% axis ij
% xlabel('time [\mus]')
% ylabel('depth[dm]')
% set(gca,'Xtick',[0:100:500],'XTickLabel',[0:100:500]*4)
% 
% ax3=subplot(1,3,3)
% axis ij
% xlabel('time [\mus]')
% ylabel('depth[dm]')
% set(gca,'Xtick',[0:100:500],'XTickLabel',[0:100:500]*4)
% 
% linkaxes([ax1 ax2 ax3])


