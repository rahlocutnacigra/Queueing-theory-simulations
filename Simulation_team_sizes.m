k=20;
p=0.1;
r=5;
h=3;

N=1:10;

k=10;
[a_exe2,d2]=simulate(k,p,r,h,N);
fig=plot(N,a_exe2,':r.','MarkerIndices',1:length(N),'MarkerSize', 15)
hold on   
errorbar(N,a_exe2,d2,':r','HandleVisibility','off')
axis([0 10 -1 60])


k1=20;
[a_exe,d]=simulate(k1,p,r,h,N);
plot(N,a_exe,':b.','MarkerIndices',1:length(N),'MarkerSize', 15) 
errorbar(N,a_exe,d,':b','HandleVisibility','off')


k3=50;
[a_exe1,d1]=simulate(k3,p,r,h,N);
plot(N(2:end),a_exe1(2:end),':g.','MarkerIndices',1:length(N)-1,'MarkerSize', 15)    
errorbar(N(2:end),a_exe1(2:end),d1(2:end),':g','HandleVisibility','off')

k4=100;
[a_exe4,d4]=simulate(k4,p,r,h,N);
plot(N(2:end),a_exe4(2:end),':m.','MarkerIndices',1:length(N)-1,'MarkerSize', 15)    
errorbar(N(2:end),a_exe4(2:end),d4(2:end),':m','HandleVisibility','off')
hold off


legend('10 developers in a team', '20 developers in a team',...
    '50 developers in a team', '100 developers in a team')

title('\lambda_{90%}, 3 minute average service')
xlabel('Number of environments') 
ylabel('Average time spent in the system [min]') 