function [scores] = score_ppg_signal_linear_slope(processed_ppg_signal)
%SCORE_PPG_LINEAR_SLOPE
% Returns the health scores of all pulses in a preprocessed
% PPG signal (via preprocess_ppg_signal(raw, timestamps)). See Victoria
% Ouyang's thesis for details -- this algorithm simply calculates
% the slope of the rising edge of each pulse.
arguments
    processed_ppg_signal (1,:) double
end

% Split signal into pulses
[~, indices] = split_ppg_signal(processed_ppg_signal);

% Calculate scores of all pulses
scores = zeros(length(indices) - 1, 1);
for i=1:length(indices) - 1 
    pulse = preprocess_ppg_pulse(indices(i) : indices(i + 1));
    [systolic_peak, ~, ~] = find_pulse_points(pulse);

    if (systolic_peak == 1) 
        scores(i) = 0.0;
    else 
        rising_slope_linear_approximation = (pulse(systolic_peak) - pulse(1)) / (systolic_peak - 1);
        scores(i) = rising_slope_linear_approximation;
    end
end

end



