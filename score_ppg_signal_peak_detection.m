function [scores] = score_ppg_signal_peak_detection(processed_ppg_signal)
%SCORE_PPG_SIGNAL_PEAK_DETECTION 
% Returns the health scores of all pulses in a preprocessed
% PPG signal (via preprocess_ppg_signal(raw, timestamps)). Uses peak
% detection to find position of dicrotic notch relative to the
% diastolic and systolic peaks.
arguments
    processed_ppg_signal (1,:) double
end

% Split signal into pulses
indices = split_ppg_signal(processed_ppg_signal);

% Calculate scores of all pulses
scores = zeros(length(indices) - 1, 1);
for i=1:length(indices) - 1 
    pulse = preprocess_ppg_pulse(processed_ppg_signal(indices(i) : indices(i + 1)));
    [systolic_peak, diastolic_peak, dicrotic_notch] = find_pulse_points(pulse);

    if (systolic_peak == diastolic_peak) 
        scores(i) = 0;
    else
        scores(i) = (pulse(systolic_peak) - pulse(dicrotic_notch)) / (pulse(systolic_peak) - pulse(diastolic_peak));
    end
end

end

