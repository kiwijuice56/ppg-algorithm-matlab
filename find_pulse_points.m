function [processed_pulse, systolic_peak, diastolic_peak, dicrotic_notch] = find_pulse_points(unprocessed_pulse)
%FIND_PULSE_POINTS Find the major anatomy points of an unprocessed PPG
%pulse (but from a processed PPG signal)

pulse = preprocess_ppg_pulse(unprocessed_pulse);

% First, smooth the pulse heavily to reduce any noise
pulse = smooth(pulse, 50);

% Then, trim a small amount from the beginning and end to remove the
% foot/onset
remove_count_front = 60;
remove_count_back = 15;
pulse = pulse(remove_count_front : length(pulse) - remove_count_back);

[~, pulse_indices] = findpeaks(pulse);

% Case 0: very poor signal
if isempty(pulse_indices)
    systolic_peak = 1;
    diastolic_peak = length(pulse);
% Case 1: the notch is clearly visible
elseif length(pulse_indices) > 1 
    systolic_peak = pulse_indices(1);
    diastolic_peak = pulse_indices(2);
% Case 2: the notch is too flat, but systolic notch is there -- use
% derivative method
else
    systolic_peak = pulse_indices(1);
    
    % Add a small offset so that we don't select the systolic peak again
    peak_offset = min([20, length(pulse) - systolic_peak]);
    
    half_pulse_gradient = gradient(pulse(pulse_indices(1) + peak_offset : length(pulse)));
    [~, zero_crossing_index] = min(abs(half_pulse_gradient));
    diastolic_peak = pulse_indices(1) + peak_offset + zero_crossing_index - 1;
end

search_ratio = 0.65; % Don't search the entire range to avoid slipping into the diastolic peak
search_end = systolic_peak + round(search_ratio * (diastolic_peak - systolic_peak));
[~, notch_relative_index] = min(pulse(systolic_peak : search_end)); 
dicrotic_notch = systolic_peak + notch_relative_index - 1;


processed_pulse = pulse;

end

