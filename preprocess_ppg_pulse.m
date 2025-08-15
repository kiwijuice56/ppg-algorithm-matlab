function [processed_ppg_pulse] = preprocess_ppg_pulse(ppg_pulse)
%PREPROCESS_PPG_PULSE Returns a processed copy of a PPG pulse

arguments
    ppg_pulse (1,:) double
end

% Normalize and rescale to [0, 1] range
ppg_pulse = ppg_pulse - mean(ppg_pulse);
ppg_pulse = ppg_pulse ./ max(abs(ppg_pulse));

% Interpolate using cubic interpolation
% We want a fixed amount of samples for all pulses
time = linspace(1, length(ppg_pulse), 500);
ppg_pulse = interp1(1:length(ppg_pulse), ppg_pulse, time, 'pchip');

processed_ppg_pulse = ppg_pulse;

end

