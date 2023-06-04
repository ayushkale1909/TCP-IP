% Define the parameters
num_nodes = 10;
RTT = 10;  
MSS = 1;   
threshold = Inf;

% Initialization
W = MSS;
throughput = zeros(1, num_nodes);
latency = zeros(1, num_nodes);

% Ring Topology
for i = 1:num_nodes
    while true
        if rand < 0.1  % simulate packet loss with 10% probability
            % Packet loss 
            threshold = W / 2;
            W = MSS;
        else
            % Packet was successfully sent
            if W < threshold
                % TCP Slow start 
                W = W * 2;
            else
                % TCP Congestion avoidance 
                W = W + MSS;
            end

            % Performance metrics
            throughput(i) = throughput(i) + W;
            latency(i) = latency(i) + RTT;
        end

        if rand < 0.01  
            break
        end
    end

    % Average latency
    latency(i) = latency(i) / throughput(i);
end

% Fairness index
fairness = (sum(throughput)^2) / (num_nodes * sum(throughput.^2));


% Results
disp(['Throughput for each node: ', num2str(throughput)]);
disp(['Latency for each node: ', num2str(latency)]);
disp(['Fairness index: ', num2str(fairness)]);

% Plot throughput and latency
figure;

subplot(2, 1, 1);
plot(1:num_nodes, throughput);
title('Throughput for each node');
xlabel('Node');
ylabel('Throughput');

subplot(2, 1, 2);
plot(1:num_nodes, latency);
title('Latency for each node');
xlabel('Node');
ylabel('Latency');

% Plot fairness index
figure;
bar(fairness);
title('Fairness index');
xlabel('Simulation');
ylabel('Fairness Index');


