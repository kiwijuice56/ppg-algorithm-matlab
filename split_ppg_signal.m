function [indices] = split_ppg_signal(ppg_signal, sampling_frequency, cutoff_frequency)
%SPLIT_PPG_SIGNAL Returns an array of indices such that each pair of
%adjacent indices forms a pulse in the ppg signal

arguments
    ppg_signal (1,:) double
    sampling_frequency (1,1) double
    cutoff_frequency (1,1) double
end

% Smooth the ppg signal aggressively using a low-pass filter.
filter_order = 50;
smooth = designfilt('lowpassfir','FilterOrder', filter_order, ...
         'CutoffFrequency', cutoff_frequency , ...
         'SampleRate', sampling_frequency);
smoothed_ppg_signal = filter(smooth, ppg_signal);

% Fix the delay caused by the filter before finding the peaks.
delay = mean(grpdelay(smooth));
reshifted_smoothed_ppg_signal = smoothed_ppg_signal(delay:length(smoothed_ppg_signal) - delay);
[~, indices] = findpeaks(-reshifted_smoothed_ppg_signal);

end

