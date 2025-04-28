function [processed_ppg_pulse] = preprocess_ppg_pulse(ppg_pulse)
%PREPROCESS_PPG_PULSE Returns a processed copy of a PPG pulse

arguments
    ppg_pulse (1,:) double
end

% Normalize and rescale to [0, 1] range
processed_ppg_pulse = normalize(ppg_pulse);
processed_ppg_pulse = rescale(processed_ppg_pulse, 0, 1);

end

