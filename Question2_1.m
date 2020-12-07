

k=300;
p=0.1;
r=3;
h=3;

l=1000; %number of arrivals we are observing
lambda=(k*p*r)/60; % we have to devide lambda by 60, because lambda tells us about arrivals/hour and need arrivals/minute

T=zeros(l,1);
t=0;
for i=1:l
    ia=exprnd(1/lambda); %we generate exponential interarrival times
    t=t+ia; % we add them up to get arrival times
    T(i)=t;
end

S2=exprnd(h,667,1); % random vector of exponential service times
S1=exprnd(10,333,1);
S=[S2;S1];
S=S(randperm(length(S)));

% Now we separate the indices of "long" and "short" testing times.
T1=zeros(333,1);
T2=zeros(667,1);
ind1=zeros(333,1);
ind2=zeros(667,1);
k=1;
q=1;
for i=1:1000
    if ismember(S(i),S1)
        T1(k)=T(i);
        ind1(k)=i;
        k=k+1;
    else
        T2(q)=T(i);
        ind2(q)=i;         
        q=q+1;
    end
end    

% SEPARATE SERVERS

w1=10;
h1=10;
k1=100;
lambda1=(k1*p*r)/60;
w2=10;
h2=3;
k2=200;
lambda2=(k2*p*r)/60;
N1=1;
N2=1;
while grade_of_service(lambda1,h1,N1,w1)<0.95
    N1=N1+1;
end
while grade_of_service(lambda2,h2,N2,w2)<0.95
    N2=N2+1;
end

D1 = queue(T1,S1,N1);
D2 = queue(T2,S2,N2);

av_3=mean(D1-T1);
av_10=mean(D2-T2);
av_sk =mean([D1;D2]-[T1;T2]);

% SHARED SERVERS
N=0;
Gos1=0;
Gos2=0;
while (Gos1<0.95)||(Gos2<0.95)
    N=N+1; 
    D=queue(T,S,N);
    ex=D-T;
    i1=0;
    i2=0;
    for i=1:1000
        if ismember(i,ind1)
            if (ex(i)-S(i))<15
                i1=i1+1;
            end
        else 
            if (ex(i)-S(i))<10
                i2=i2+1;
            end
        end
    end
    Gos1=i1/333;
    Gos2=i2/667;       
end


    
% N=1:11;
% a_exe=zeros(length(N),1);
% d=zeros(length(N),1);
% for i=1:length(N) %for every different N we simulate the queueing process
%     D = queue(T,S2,N(i));
%     Exe_t=D-T; % execution time is difference between departure time and arrival time
%     a_exe(i)=mean(Exe_t); % average execution time
%     d(i)=std(Exe_t); % standard deviation of execution times
% end
% 
% av_3=zeros(length(N),1);
% av_10=zeros(length(N),1);
% av_sk=zeros(length(N),1);
% D_k=zeros(length(N),1);
% 
% for j=1:length(N)
%     D = queue(T,S2,N(j));
%     Exe_t=D-T;
%     T1=zeros(333,1);
%     T2=zeros(667,1);
%     Exe_t1=zeros(333,1);
%     Exe_t2=zeros(667,1);
%     k=1;
%     q=1;
%     for i=1:1000
%         if ismember(S2(i),S1)
%             T1(k)=T(i);
%             Exe_t1(k)=D(i)-T(i);
%             k=k+1;
%         else T2(q)=T(i);
%             Exe_t2(q)=D(i)-T(i);
%             q=q+1;
%         end
%     end
% 
%     av_3(j)=mean(Exe_t2); %mean value of time spent in a system where mean test execution time is 3 min
%     av_10(j)=mean(Exe_t1); %mean value of time spent in a system where mean test execution time is 10 min
%     av_sk(j)=mean(Exe_t); %mean value of time spent in a system
%     D_k(j)=D(1000); %stopping point of the process
% end
% 
% a_exe3=zeros(length(N),1);
% a_exe10=zeros(length(N),1);
% a_exe=zeros(length(N),1);
% for i=1:length(N)-1 %for every different N we simulate the queueing process
%     j=length(N)-i;
%     D1 = queue(T2,S,N(i));
%     D2 = queue(T1,S1,N(i));
%     Exe_t1=D1-T2; % execution time is difference between departure time and arrival time
%     Exe_t2=D2-T1;
%     a_exe3(i)=mean(Exe_t1); % average execution time
%     a_exe10(i)=mean(Exe_t2);
% end
% 
% fig=plot(N,av_sk,':b.','MarkerIndices',1:length(N),'MarkerSize', 15) 
% hold on
% plot(N,a_exe, ':m.','MarkerIndices',1:length(N),'MarkerSize', 15) 
% % plot(N,a_exe,':b.','MarkerIndices',1:length(N),'MarkerSize', 15) 
% % errorbar(N,a_exe,d,':b','HandleVisibility','off')
% 
% % plot(N(5:end),a_exe(5:end),':b.','MarkerIndices',5:length(N),'MarkerSize', 15) 
% % errorbar(N(5:end),a_exe(5:end),d(5:end),':b','HandleVisibility','off')
% legend('Shared servers', 'Separate servers')
% %title('Average time in the system, average testing time = 3 min')
% xlabel('Number of environments') 
% ylabel('Average time spent in the system [min]') 
% hold off

z=0;
for j=1:1000
    for i=1:1000
        if D(i)>480
            z=z+i;
            break
        end
    end
end
z/1000