function [smoothed_signal] = smooth(signal, n)
%SMOOTH 
% Returns a smoothed and unshifted signal with window size n
arguments
    signal (1,:) double
    n (1,1) int64
end
    smoothing_coef = ones(1, double(n)) / double(n);
    smoothed_signal = filter(smoothing_coef, 1, signal);
end

