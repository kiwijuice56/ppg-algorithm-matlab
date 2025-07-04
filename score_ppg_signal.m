function [scores] = score_ppg_signal(ppg_signal, timestamps)
%SCORE_PPG_SIGNAL Returns the scores of all pulses in a raw PPG signal
%See https://drive.google.com/file/u/3/d/1pe0JXUnOhZpmCMGCEVop8Zxzz9kD3FCD/view

arguments
    ppg_signal (1,:) double
    timestamps (1,:) int64
end

% Preprocess signal and split it into pulses
ppg_signal = preprocess_ppg_signal(ppg_signal, timestamps);
[~, indices] = split_ppg_signal(ppg_signal);

% Calculate scores of all pulses
scores = zeros(length(indices) - 1, 1);
for i=1:length(indices) - 1
    pulse = ppg_signal(indices(i) : indices(i + 1));
    pulse = preprocess_ppg_pulse(pulse);
    
    n = 15;
    [cos_coef, sin_coef] = calculate_fourier_coefficients(pulse);
    cos_coef = cos_coef(1:n);
    weights = cos_coef / sum(cos_coef);
    scores(i) = dot(weights, (1:n));

    sin_coef = sin_coef(1:n);
    weights = sin_coef / sum(sin_coef);
    scores(i) = scores(i) + dot(weights, (1:n));
end

end

