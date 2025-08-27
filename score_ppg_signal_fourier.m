function [scores] = score_ppg_signal_fourier(processed_ppg_signal, coefficient_count)
%SCORE_PPG_SIGNAL_FOURIER 
% Returns the health scores of all pulses in a preprocessed
% PPG signal (via preprocess_ppg_signal(raw, timestamps)). See 
% https://drive.google.com/file/u/3/d/1pe0JXUnOhZpmCMGCEVop8Zxzz9kD3FCD/view
% for complete details on algorithm, developed by Shreya.
arguments
    processed_ppg_signal (1,:) double
    coefficient_count (1,1) int64
end

% Preprocess signal and split it into pulses
[~, indices] = split_ppg_signal(processed_ppg_signal);

% Calculate scores of all pulses
scores = zeros(length(indices) - 1, 1);
for i=1:length(indices) - 1
    pulse = preprocess_ppg_pulse(processed_ppg_signal(indices(i) : indices(i + 1)));
    
    n = double(coefficient_count);
    [cos_coef, sin_coef] = calculate_fourier_coefficients(pulse);
    combined_coef = cos_coef(1:n);
    weights = combined_coef / sum(combined_coef);
    scores(i) = dot(weights, 1:n);

    combined_coef = sin_coef(1:n);
    weights = combined_coef / sum(combined_coef);
    scores(i) = scores(i) + dot(weights, 1:n);
end

end

