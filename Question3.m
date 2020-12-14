ex = 0.15; % expences for a server per hour
wex = 10; % expences for developer per hour
Gos = 0.95; %required grade of service

k=20;
p=0.1;
r=3;
w=5; %acceptable waiting time is 5 minutes

h=1:15; %mean duration of tests
lambda=(k*p*r)/60;
WE=0;
SE=0;

for j=1:1000
    waiting_expences = zeros(1, length(h));
    server_expences = zeros(1,length(h));
    N1 = zeros(1,length(h));
    for i=1:length(h)
        N=1;
        while grade_of_service(lambda,h(i),N,w)<Gos
            N=N+1;
        end
        [D,W] = simulate(k,p,r,h(i),N);
        waiting_expences(i) = (sum(W)/60) *wex; % sum of all time all of the developers spent waiting * work expences
        server_expences(i)= (D(end)/60)*N*ex;
        N1(i)=N;
    end
    WE=WE+waiting_expences;
    SE=SE+server_expences;
end
WE=WE/50;
SE=SE/50;

plot(h,WE,'-m.','MarkerIndices',1:length(h),'MarkerSize', 15)
hold on
plot(h,SE,'-g.','MarkerIndices',1:length(h),'MarkerSize', 15)
plot(h,SE+WE,'-c.','MarkerIndices',1:length(h),'MarkerSize', 15)
plot(h,N1,'-b.','MarkerIndices',1:length(h),'MarkerSize', 15)

title('Costs per month for different h')
legend({'Costs for workers waiting','Costs for servers','Total costs','Number of servers'},'Location','northwest')
set(gca,'XTick', [0:length(h)],'XtickLabel',[0:length(h)])
xlabel('Average Tests Running Time')
ylabel('Costs in U')
hold off