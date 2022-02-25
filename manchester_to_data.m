clc
close all
clear all
data=textread('creta_new.txt');
data=round(data(:,2));
% data=manchester';
% %data=cast(data,'int8');
data=[0;0;data]; %pading values in the start so as to identify change in starting rows
change=[];

%this loop will give points where the values of data is changing
for i=1:length(data)-1
    if data(i)~=data(i+1)
        
        change=[change;i];
    end
end

width_bit=diff(change); % finding bit width
num_samples=round(sum(width_bit(find(width_bit <= 90)))/sum((width_bit <= 90))); %finding avg bit width
data=data((change(1)+1):change(end));
data=[zeros(num_samples,1) ;data ;zeros(num_samples,1)];
width_bit = [num_samples;width_bit;num_samples];

clock=[];
j=[2:2:length(width_bit)];
k=[1:2:length(width_bit)];
for i=1:(round(length(data)/num_samples*2))-1 % finding how many clock samples are needed for the data
    
    clock=[clock ;ones(width_bit(k(i)),1) ;zeros(width_bit(j(i)),1)];
    
end
clock=[clock ;ones(width_bit(k(end)),1)];

if length(clock)~=length(data)  % as we have taken num_samples as average, sometimes actual data samples will be more
                                % to compensate, we add more clock data
   clock=[clock ;ones(num_samples,1) ;zeros(num_samples,1)];
end

visualise = data(1:1000); % to see graphically 1000 points of the logic, if you want all the data then replace 1000 with data.
clock=clock(1:length(visualise));    % after clock data is incresesd, we will consider clock only till data exits 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
t=0:length(clock)-1;              % initially we have offset data by 2 bits = [0;0;data], so we consider data from its actual
                                  % value
x=5;
subplot(x,1,1)
plot(clock(1:length(t)),'k'),hold on
title('clock')

subplot(x,1,2)
plot(data(1:length(t)),'k'),hold on
title('manchester coded data ')
% 
 rec_diff_data=and(data(1:length(t)),clock(1:length(t)));
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
subplot(x,1,3)
plot(rec_diff_data,'k'),hold on
title('recovered diff data')

cmp_clock=~clock(1:length(t));
% shifted_rec_diff_data=and(~or(data(1:length(t)),rec_diff_data),cmp_clock);
shifted_rec_diff_data=[zeros(num_samples,1);rec_diff_data];
rec_diff_data=[rec_diff_data;zeros(num_samples,1)];
subplot(x,1,4)
plot(shifted_rec_diff_data,'k'),hold on
title('shifted rec diff data')

subplot(x,1,5)
recovered_data=or(shifted_rec_diff_data,rec_diff_data);
plot(recovered_data,'k')
title('recovered data')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
recov1=recovered_data;
