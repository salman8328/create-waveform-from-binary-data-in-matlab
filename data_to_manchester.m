clc
close all
%data=randi([0 1],1,30);
start=0;
ends=67;
data1=binary_bit(start+1:ends);
data_mod=[];
num_samples=num_samples*2;
 clock=[];
for i=1:length(data1)
    
     clock=[clock ;ones(round(num_samples/2),1) ;zeros(floor(num_samples/2),1)];
    
    if data1(i)==1
        data_mod=[data_mod ;ones(num_samples,1)];
   
    elseif data1(i)==0
        data_mod=[data_mod ;zeros(num_samples,1)];
        
    end
    
% t=0:length(data_mod)-1;
% subplot(411)
% title('clock')
% plot(t,clock(1:length(t)),'k'), hold on
% pause(0.1)
% 
% subplot(412)
% title('data')
% plot(t,data_mod,'k'), hold on
% pause(0.1)
% 
% subplot(413)
% title('diff data ')
% diff_data=and(clock,data_mod);
% plot(t,diff_data,'k'), hold on
% pause(0.1)
% 
% manchester=diff_data + and((clock==0),(data_mod==0));
% subplot(414)
% title('manchester')
% plot(t,manchester,'k'), hold on
% pause(0.1)

end

t=num_samples*start:num_samples*ends-1;

if length(t)>length(data)
    t1=0:length(data)-1;
else
    t1=t;
end
x=7;
subplot(x,1,1)
plot(t,clock)
title('clock')

subplot(x,1,2)
plot(t1,data(t1+1))
title('data')

subplot(x,1,3)
plot(t1,recovered_data(t1+1))
title('rec data')

subplot(x,1,4)
plot(t1,rec_diff_data(t1+1))
title('rec diff data')
% subplot(x,1,3)
% plot(linspace(t(1),t(end),ends-start),data1)
% title('binary data')

diff_data=and(clock,data_mod);
manchester=or(diff_data,and(~clock,~data_mod));

subplot(x,1,5)
plot(linspace(t(1),t(end),ends-start),data1)
title('binary')
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(x,1,6)
plot(t,manchester)
title('manchester')

arduino_code=manchester(round(num_samples/4):round(num_samples/2):end);
subplot(x,1,7)
plot(linspace(t(1),t(end),(ends-start)*2),arduino_code)
title('code')
% change=[];
% b=manchester;
% for i=1:length(b)-1
%     if b(i)~=b(i+1)
%         
%         change=[change;i];
%     end
% end
% c=diff(change);
% [bins,p]=hist(c)

% bool=fopen('bit_cret.txt','w');
% fprintf(bool,'%i,\n',arduino_code);
% fclose(bool);
% sampling_freq=192000;
% each_samp_duration=1/sampling_freq;
% dura_each_bit_in_manchester= num_samples*each_samp_duration/2
% t=0:100;
% subplot(211),
% plot(t,arduino_code(t+1)),
% subplot(212),
% plot(linspace( t(1),t(end),length(t) ),binary_bit(round( length(t)/2 ) ) )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% subplot(x,1,3)
% plot(data(t))
% 
%  rec_diff_data=and(manchester(t),clock(t));
%  cmp_clock=~clock(t);
% shifted_rec_diff_data=and(~or(manchester(t),rec_diff_data),cmp_clock);
% recovered_data=or(shifted_rec_diff_data,rec_diff_data);
% subplot(x,1,4)
% plot(recovered_data)
% subplot(x,1,5)
% plot(manchester(t),'k')