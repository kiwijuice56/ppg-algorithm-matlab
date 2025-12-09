function [average_pulse] = average_pulse(processed_ppg_signal)
%AVERAGE_PULSE 
% Returns the average pulse waveform of the processed PPG signal

arguments
    processed_ppg_signal (1,:) double
end

indices = split_ppg_signal(processed_ppg_signal);
pulses = {}; % Cell array to hold individual pulses
max_length = 0; % Variable to track the maximum pulse length

for i = 1:length(indices) - 1
    pulse = preprocess_ppg_pulse(processed_ppg_signal(indices(i) : indices(i + 1)));
    pulses{end + 1} = pulse; % Store each pulse in the cell array
    max_length = max(max_length, length(pulse)); % Update max_length
end

% Initialize a summed pulse with zeros
summed_pulse = zeros(max_length, 1);
num_pulses = length(pulses);

% Sum the pulses, left-aligning them
for i = 1:num_pulses
    pulse_length = length(pulses{i});
    summed_pulse(1:pulse_length) = summed_pulse(1:pulse_length) + pulses{i}(:); % Left-align
end

% Calculate the average pulse
average_pulse = summed_pulse / num_pulses;

end