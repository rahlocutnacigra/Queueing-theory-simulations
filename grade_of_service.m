function g = grade_of_service(lambda,h,N,w)
%   lambda: arrival rate /hour
%   h: average service time (in minutes)
%   N: number of servers
%   w: acceptable waiting time (in minutes)

ro=(lambda/60)*h;
s=0;
for i=0:N-1
    s=s+(ro^i)/factorial(i);
end
erlang=(N*ro^N)/(factorial(N)*(N-ro)*s+N*ro^N);
f=-w*(N-ro)/h;
g=1-erlang*exp(f);


end

