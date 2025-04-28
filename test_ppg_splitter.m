% Data measured in ms
raw_ppg_data = readmatrix("example_ppg_camera.csv");
ppg_pulse = raw_ppg_data(:,:);
sampling_frequency = 50; % Hertz

% Resample the pulse to a higher rate to increase resolution,
% using cubic spline interpolation
resampling_scale = 4; 
time = linspace(ppg_pulse(1, 1), ppg_pulse(length(ppg_pulse), 1), resampling_scale * length(ppg_pulse));
ppg_signal = interp1(ppg_pulse(:, 1), ppg_pulse(:, 2), time, 'pchip');

cutoff_frequency = 1; % Hertz
indices = split_ppg_signal(ppg_signal, ...
    sampling_frequency * resampling_scale, cutoff_frequency * resampling_scale);

hold on;

for i = 1:10 
    plot(preprocess_ppg_pulse(ppg_signal(indices(i) : indices(i + 1))))
end

title('Splitting a PPG signal into pulses')
ylabel('Amplitude') 
xlabel('Time')

hold off;
