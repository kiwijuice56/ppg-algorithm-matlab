function [processed_ppg_signal] = preprocess_ppg_signal(ppg_signal)
%PREPROCESS_PPG_PULSE Returns a processed copy of a PPG signal

arguments
    ppg_signal (1,:) double
end

% Invert to correct orientation
processed_ppg_signal = -ppg_signal;

end

