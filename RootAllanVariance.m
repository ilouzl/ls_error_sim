function [T,sigma] = RootAllanVariance(x,fs,pts,overlapped)
% x - input data (in columns)
% fs - samping rate
% pts - numbr of points in th AVAR output (approximated)
% overlapped - flag to use overlapped AVAR method
x = x(:);
[N,M] = size(x);                    % figure out how big the output data set is
n = 2.^(0:floor(log2(N/2)))';
maxN = n(end);                      % determine largest bin size
endLogInc = log10(maxN);
m = unique(ceil(logspace(0,endLogInc,pts)))';  % create log spaced vector average factor
t0 = 1/fs;                                      % t0 = sample interval
T = m*t0;                                       % T = length of time for each cluster
h = waitbar(0,'Calculating AVAR...');
if ~overlapped
    %% classic AVAR according Woodman, 2009
    for i=1:length(m)
        waitbar(i/length(m),h,'Calculating AVAR...');
        N_tmp = floor(N/m(i))*m(i);
        y = x(1:N_tmp);
        y = reshape(y,m(i),N_tmp/m(i));
        a = mean(y,1);
        sigma2(i) = sum(diff(a).^2)/(2*((N_tmp/m(i))-1));
    end
else
    %% overlapped AVAR by http://cache.freescale.com/files/sensors/doc/app_note/AN5087.pdf
    theta  = cumsum(x)/fs;% integration of samples over time to obtain output angle ?
    sigma2 = zeros(length(T),M);% array of dimensions (cluster periods) X (#variables)
    for i=1:length(m)% loop over the various cluster sizes
        waitbar(i/length(m),h,'Calculating AVAR...');
        for k=1:N-2*m(i)% implements the summation in the AV equation
            sigma2(i,:) = sigma2(i,:) + (theta(k+2*m(i),:) - 2*theta(k+m(i),:) + theta(k,:)).^2;
        end
    end
    sigma2 = sigma2./repmat((2*T.^2.*(N-2*m)),1,M);  
end
close(h);
sigma  = sqrt(sigma2);







