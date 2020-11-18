% We draw a plot for 20 developers in a team and for p=0.1. We calculate
% average execution time for different mean service times: h=1, h=3 and
% h=6. We also change r to get diffenet plots


k=20;
p=0.1;
r=9;

N=1:10;

h2=1;
[a_exe2,d2]=simulate(k,p,r,h2,N);
fig=plot(N,a_exe2,':r.','MarkerIndices',1:length(N),'MarkerSize', 15)
hold on   
errorbar(N,a_exe2,d2,':r','HandleVisibility','off')
axis([0 10 -1 60])


h=3;
[a_exe,d]=simulate(k,p,r,h,N);
plot(N,a_exe,':b.','MarkerIndices',1:length(N),'MarkerSize', 15) 
errorbar(N,a_exe,d,':b','HandleVisibility','off')


h1=6;
[a_exe1,d1]=simulate(k,p,r,h1,N);
plot(N(2:end),a_exe1(2:end),':g.','MarkerIndices',1:length(N)-1,'MarkerSize', 15)    
errorbar(N(2:end),a_exe1(2:end),d1(2:end),':g','HandleVisibility','off')
hold off

legend('Average service time 1 min', 'Average service time 3 min',...
    'Average service time 6 min')

title('\lambda_{99%}, 20 developers in a team')
xlabel('Number of environments') 
ylabel('Average time spent in the system [min]') 