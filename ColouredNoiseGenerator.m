%% based on  Hristo Zhivomirov Noise Generator
function y = ColouredNoiseGenerator(N,beta,sigma)

% function: y = ColouredNoiseGenerator(N,beta) 
% N - number of samples to be returned in row vector
% beta - noise PSD slope
% y - row vector of noise samples with PSD behaves like f^beta 

% The function generates a sequence of coloured noise samples. 
% In terms of power at a constant bandwidth, f^beta noise changes at beta*3 dB per octave. 

% define the length of the vector
% ensure that the M is even
if rem(N,2)
    M = N+1;
else
    M = N;
end

% generate white noise
x = sigma*randn(1, M);

% FFT
X = fft(x);

% prepare the f^beta filter vector
NumUniquePts = M/2 + 1;
n = 1:NumUniquePts;
n = n.^(beta/2);

% multiplicate the left half of the spectrum so the power spectral density
% is proportional to the frequency by factor f^beta, i.e. the
% amplitudes are proportional to f^(beta/2)
X(1:NumUniquePts) = X(1:NumUniquePts).*n;

% prepare a right half of the spectrum - a copy of the left one,
% except the DC component and Nyquist frequency - they are unique
X(NumUniquePts+1:M) = real(X(M/2:-1:2)) -1i*imag(X(M/2:-1:2));

% IFFT
y = ifft(X);

% prepare output vector y
y = real(y(1, 1:N));

% ensure unity standard deviation and zero mean value
% y = y - mean(y);
% yrms = sqrt(mean(y.^2));
% y = y/yrms;

end