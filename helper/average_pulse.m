function [average_pulse] = average_pulse(processed_ppg_signal)
%AVERAGE_PULSE 
% Returns the average pulse waveform of the processed PPG signal

arguments
    processed_ppg_signal (1,:) double
end

indices = split_ppg_signal(processed_ppg_signal);
pulse_length = 500; 
summed_pulse = zeros(pulse_length, 1);
num_pulses = 0;
for i = 1:length(indices) - 1
    pulse = preprocess_ppg_pulse(processed_ppg_signal(indices(i) : indices(i + 1)));
    summed_pulse = summed_pulse + pulse(:);
    num_pulses = num_pulses + 1;
end

average_pulse = summed_pulse / num_pulses;

end