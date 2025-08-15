function [scores, debug_pulse, debug_systolic_peak, debug_diastolic_peak, debug_dicrotic_notch] = score_ppg_signal_derivative(processed_ppg_signal)
%SCORE_PPG_SIGNAL Returns the health scores of all pulses in a preprocessed
% PPG signal (via preprocess_ppg_signal(raw, timestamps)). Uses first
% derivative.
arguments
    processed_ppg_signal (1,:) double
end

% Split signal into pulses
[~, indices] = split_ppg_signal(processed_ppg_signal);

% Calculate scores of all pulses

scores = zeros(length(indices) - 1, 1);
for i=1:length(indices) - 1 
    [pulse, systolic_peak, diastolic_peak, dicrotic_notch] = find_pulse_points(processed_ppg_signal(indices(i) : indices(i + 1)));

    scores(i) = (pulse(systolic_peak) - pulse(dicrotic_notch)) / (pulse(systolic_peak) - pulse(diastolic_peak));

    if i == 2
        debug_pulse = pulse;
        debug_systolic_peak = systolic_peak;
        debug_diastolic_peak = diastolic_peak;
        debug_dicrotic_notch = dicrotic_notch;
    end
end

end

