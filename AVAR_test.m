close all; clc;
L = 100000;
x = randn(1,L)+pinknoise(L)+rednoise(L);
% x = randn(1,100000) + cumsum(x);
[T,sigma] = RootAllanVariance(x,fs,pts,overlapped);