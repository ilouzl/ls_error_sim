%% according Woodman 2009 
% function ravar = RootAllanVariance(x)
x = randn(1,10000);
N = length(x);
Nlog = floor(log2(N))-1;
for i=0:Nlog
    tau = 2^i;
    N_tmp = floor(N/tau)*tau;
    y = x(1:N_tmp);
    y = reshape(y,tau,N_tmp/tau);
    a = mean(y,1);
    ravar(i+1) = sum(diff(a).^2)/(2*(N_tmp-1));
end
    

