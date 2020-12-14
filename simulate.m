function [D,W] = simulate(k,p,r,h,N)

%   k: the number of developers in the team
%   p: percentage of a maximum number of developer’s contributions 
%      occurring during the busy development hour
%   r: number of all considered daily contributions per developer
%   h: average service time (in minutes)
%   N: vector of different numbers of servers

l=k*r; %number of arrivals we are observing
lambda=(k*p*r)/60; % we have to devide lambda by 60, because lambda tells us about arrivals/hour and need arrivals/minute

T=zeros(l,1);
t=0;
for i=1:l
    ia=exprnd(1/lambda); %we generate exponential interarrival times
    t=t+ia; % we add them up to get arrival times
    T(i)=t;
end

S=exprnd(h,l,1); % random vector of exponential service times

D=queue(T,S,N);
W=D-T-S;

% % for i=1:length(N) %for every different N we simulate the queueing process
% %     D = queue(T,S,N(i));
% %     Exe_t=D-T; % execution time is difference between departure time and arrival time
% %     a_exe(i)=mean(Exe_t); % average execution time
% %     d(i)=std(Exe_t); % standard deviation of execution times
% 
% last_D=zeros(l,length(N));
% last_D1=zeros(1,length(N));
% for i=1:length(N) %for every different N we simulate the queueing process
%     D = queue(T,S,N(i));
%     last_D(:,i)=D;
%     last_D1(i)=D(end); % finishing time
end

