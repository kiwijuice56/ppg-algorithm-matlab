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

% Find the start and end of each pulse by smoothing aggressively
% before peak finding using a low-pass filter
frequency_pass = 0.5;
smoothed_ppg_signal = lowpass(ppg_signal, frequency_pass * resampling_scale, base_sampling_rate * resampling_scale, 'ImpulseResponse', 'iir');
[peaks, indices] = findpeaks(-smoothed_ppg_signal);

hold on;

plot(ppg_signal)
plot(indices, ppg_signal(indices),'*r')

title('Estimating a PPG pulse using first 10 fourier coefficients')
ylabel('Amplitude') 
xlabel('Time')
legend({'Original'},'Location','southwest')

hold off;
