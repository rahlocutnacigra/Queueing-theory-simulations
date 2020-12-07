k=20;
p=0.1;
r=9;
h=5;
w=5;

N_95=1;
lambda=(k*p*r)/60;
Gos_95=[];
Gos=[0,0,0];
Servers=[0,0,0];
while grade_of_service(lambda,h,N_95,w)<0.95
    Gos_95(N_95)=grade_of_service(lambda,h,N_95,w);
    N_95=N_95+1;
end
Gos_95(N_95)=grade_of_service(lambda,h,N_95,w);
Gos(2)=Gos_95(N_95);
Servers(2)=N_95;

N_90=1;
Gos_90=[];
while grade_of_service(lambda,h,N_90,w)<0.90
    Gos_90(N_90)=grade_of_service(lambda,h,N_90,w);
    N_90=N_90+1;
end
Gos_90(N_90)=grade_of_service(lambda,h,N_90,w);
Gos(1)=Gos_90(N_90);
Servers(1)=N_90;

N_98=1;
Gos_98=[];
while grade_of_service(lambda,h,N_98,w)<0.98
    Gos_98(N_98)=grade_of_service(lambda,h,N_98,w);
    N_98=N_98+1;
end
Gos_98(N_98)=grade_of_service(lambda,h,N_98,w);
Gos(3)=Gos_98(N_98);
Servers(3)=N_98;


N_100=1;
Gos_100=[];
while grade_of_service(lambda,h,N_100,w)<1
    Gos_100(N_100)=grade_of_service(lambda,h,N_100,w);
    N_100=N_100+1;
end
Gos_100(N_100)=grade_of_service(lambda,h,N_100,w);
Gos(4)=Gos_100(N_100);
Servers(4)=N_100;

bar(Servers)
set(gca,'xticklabel',{'90%','95%', '98%', '100%'})
set(gca, 'YTick', [0:25], 'YTickLabel',[0:1:25])
xlabel('Required Grade of Service')
ylabel('Number of Servers')

t1=0;
t2=0;
t3=0;
t4=0;
for i=1:1000
    [last_D, last_D1]=simulate(k,p,r,h,Servers);
    t1=t1+last_D1(1);
    t2=t2+last_D1(2);
    t3=t3+last_D1(3);
    t4=t4+last_D1(4);
    
end
hours=[t1/60000,t2/60000,t3/60000,t4/60000];



