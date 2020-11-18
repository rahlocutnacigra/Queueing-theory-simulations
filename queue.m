function D = queue(T,S,N)
%   Funciton queue simulates a queueing process for
%   T: vector of arrival times
%   S: vector of service times
%   N: number of servers

l=length(T);
Q=[]; % waiting queue - empty at the beginning
t=0; % we start at time 0
Av=N; % at the beeginning we have N available servers
D=zeros(l,1); % initializing vector of departure times
end_service=[]; % list of times, when servers are getting free
i=1;
while i<=l
    if isempty(Q)&& Av>0 % if we have an empty queue and available servers, the arriving customer can be served right away
        if isempty(end_service) % when end_service is empty, we have no customers in the system
            end_service=T(i)+S(i); %we add finishing time in the end_service list
            D(i)=T(i)+S(i);
            Av=Av-1; % one of the servers is now serving the i-th customer and isn't available anymore
            t=T(i); % we set currnet time to arrival time of i-th customer
            i=i+1;
        else
            if T(i)<end_service(1)
                end_service(end+1)=T(i)+S(i); 
                D(i)=T(i)+S(i);
                Av=Av-1; 
                t=T(i); 
                i=i+1; 
                end_service=sort(end_service, 'ascend'); % we sort the list, so the first service that will be finished is in the beginning
            else % a server finishes service before i-th arrival
                t=end_service(1); % we set current time to end of the service
                end_service=end_service(2:end); % we delete the ending time from the list
                Av=Av+1; % we make the server available for new customesrs
            end
        end
    elseif ~isempty(Q)&&Av>0 % there are elements in a queue and also available servers
        Av=Av-1; % one of the servers isn't available any more
        end_service(end+1)=t+S(Q(1)); % the fist element of the queue is now being served
        D(Q(1))=t+S(Q(1));
        Q=Q(2:end); % the fist elelment is no longer in a queue
        end_service=sort(end_service, 'ascend');
    elseif Av==0 % there are no avaliable servers
        if end_service(1)>T(i)
            Q(end+1)=i; % we put the i-th customer at the end of the queue
            t=T(i);
            i=i+1;
        else
            t=end_service(1);
            end_service=end_service(2:end);
            Av=Av+1;
            end_service=sort(end_service, 'ascend');
        end
    end
end
% when the i-th arrival aoccurs, we can still have customers in a queue, so
% we have to empty the queue
while ~isempty(Q)
    if Av==0 %if there are no available servers, we move to the fist departure and make one of the servers available
        t=end_service(1);
        end_service=end_service(2:end);
        Av=Av+1;
    else %if there is an avilable server, we use it to serve the first customer in a queue
        Av=Av-1;
        end_service(end+1)=t+S(Q(1));
        D(Q(1))=t+S(Q(1));
        Q=Q(2:end);
        end_service=sort(end_service, 'ascend');
    end
end
end

