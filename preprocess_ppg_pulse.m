function [processed_ppg_signal] = preprocess_ppg_pulse(ppg_signal)
%PREPROCESS_PPG_PULSE Returns a processed copy of a PPG signal

arguments
    ppg_signal (1,:) double
end

% Normalize and rescale to [0, 1] range
processed_ppg_signal = normalize(ppg_signal);
processed_ppg_signal = rescale(processed_ppg_signal, 0, 1);

end

