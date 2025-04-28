% Eyeball a single heartbeat. Data measured in ms.
% TODO: replace with routine to find average PPG signal 
raw_ppg_data = readmatrix("example_ppg_camera.csv");
ppg_pulse = raw_ppg_data(:,:);
base_sampling_rate = 50;

% Resample the pulse to a higher rate to increase resolution,
% using cubic spline interpolation
resampling_scale = 4; 
time = linspace(ppg_pulse(1, 1), ppg_pulse(length(ppg_pulse), 1), resampling_scale * length(ppg_pulse));
ppg_signal = interp1(ppg_pulse(:, 1), ppg_pulse(:, 2), time, 'pchip');

% Smooth the ppg signal aggressively using a low-pass filter
filter_order = 50;
frequency_cutoff = 1;
smooth = designfilt('lowpassfir','FilterOrder', filter_order, ...
         'CutoffFrequency', frequency_cutoff * resampling_scale, ...
         'SampleRate', base_sampling_rate * resampling_scale);
smoothed_ppg_signal = filter(smooth, ppg_signal);

% Fix the delay caused by the filter before finding the peaks
delay = mean(grpdelay(smooth));
reshifted_smoothed_ppg_signal = smoothed_ppg_signal(delay:length(smoothed_ppg_signal) - delay);
[peaks, indices] = findpeaks(-reshifted_smoothed_ppg_signal);

hold on;

for i = 1:10 
    plot(ppg_signal(indices(i) : indices(i + 1)))
end

title('Splitting a PPG signal into pulses')
ylabel('Amplitude') 
xlabel('Time')

hold off;
