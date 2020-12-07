% Number of developers: 300
k=100;
h=10; % 3 minutes average test times
p=0.1; % % of commits in peak hour
r=3; % commits per day per developer
w=15; %acceptable waiting time
lambda=(k*p*r)/60;
N=1;
Gos=[];
while grade_of_service(lambda,h,N,w)<0.95
    Gos(N)=grade_of_service(lambda,h,N,w);
    N=N+1;
end
Gos(N)=grade_of_service(lambda,h,N,w);
x=1:N;

% plot(x,Gos)
fig=plot(x,Gos,'-b.','MarkerIndices',1:N,'MarkerSize', 15) 

title('GoS for different numbers of environments')
xlabel('Number of environments') 
ylabel('Grade of service') 