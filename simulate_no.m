function N = simulate_no()
%   k: the number of developers in the team
%   p: percentage of a maximum number of developer’s contributions 
%      occurring during the busy development hour
%   r: number of all considered daily contributions per developer
%   h: average service time (in minutes)
%   N: vector of different numbers of servers

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
end

