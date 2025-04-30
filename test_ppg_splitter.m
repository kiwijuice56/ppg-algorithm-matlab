% Tests and plots the PPG pulse splitting procedure

% Data measured in ms
ppg_signal = read_ppg_signal(readmatrix("data/example_ppg_camera.csv"), 4);
sampling_frequency = 50; % Hertz
cutoff_frequency = 1; % Hertz

indices = split_ppg_signal(ppg_signal, ...
    sampling_frequency * resampling_scale, cutoff_frequency * resampling_scale);

clf('reset');

hold on;
for i = 1:length(indices) - 1
    plot(preprocess_ppg_pulse(ppg_signal(indices(i) : indices(i + 1))))
end
hold off;

title('Splitting a PPG signal into its pulses');
ylabel('Amplitude');
xlabel('Time');