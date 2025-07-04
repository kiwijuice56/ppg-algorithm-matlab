function [smoothed, indices] = split_ppg_signal(ppg_signal)
%SPLIT_PPG_SIGNAL Returns an array of indices such that each pair of
%adjacent indices forms a pulse in the ppg signal. Also returns smoothed
%PPG signal, but this is only for debugging

arguments
    ppg_signal (1,:) double
end

% Smooth the ppg signal aggressively using a moving average
n = 30;
smoothing_coef = ones(1, n)/ n;
smoothed_ppg_signal = filter(smoothing_coef, 1, ppg_signal);
delay = floorDiv(length(smoothing_coef) - 1, 2);


% Fix the delay caused by the filter before finding the peaks
reshifted_smoothed_ppg_signal = smoothed_ppg_signal(delay:length(smoothed_ppg_signal) - delay);
[~, indices] = findpeaks(-reshifted_smoothed_ppg_signal);
smoothed = reshifted_smoothed_ppg_signal;

end

