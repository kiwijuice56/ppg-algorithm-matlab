% Eyeball a single heartbeat.
% TODO: replace with routine to find average PPG signal 
raw_ppg_data = readmatrix("example_ppg_camera.csv");
ppg_pulse = raw_ppg_data(44:74,:);

% Resample the pulse to a higher rate to increase resolution,
% using cubic spline interpolation.
resampling_scale = 32;
time = linspace(ppg_pulse(1, 1), ppg_pulse(length(ppg_pulse), 1), resampling_scale * length(ppg_pulse));
ppg_value = interp1(ppg_pulse(:, 1), ppg_pulse(:, 2), time, 'pchip');

% Normalize and rescale to [0, 1] range
ppg_value = normalize(ppg_value);
ppg_value = rescale(ppg_value, 0, 1);

% Calculate the fourier transform + coefficients.

% FFT returns the coefficients in complex form, but we can convert that
% into the real form (sin/cos) using Euler's identity. 
% https://en.wikipedia.org/wiki/Sine_and_cosine_transforms#Relation_with_complex_exponentials
fourier_transform = fft(ppg_value);
cosine_coefficients = real(fourier_transform);
sine_coefficients = -imag(fourier_transform);

% Test: recreate signal using coefficients.
recreated_signal = zeros(length(ppg_value), 1);

coefficient_count = 10;

for x=1:1:length(ppg_value)
    time_ratio = x / length(ppg_value);
    recreated_signal(x) = sine_coefficients(1);
    for n=1:1:coefficient_count
        sine_term   = sine_coefficients(n + 1)   * sin(2 * pi * time_ratio * n);
        cosine_term = cosine_coefficients(n + 1) * cos(2 * pi * time_ratio * n);
        
        recreated_signal(x) = recreated_signal(x) + cosine_term + sine_term;
    end
end

recreated_signal = normalize(recreated_signal);
recreated_signal = rescale(recreated_signal, 0, 1);

hold on
plot(ppg_value)
plot(recreated_signal)
title('Estimating a PPG pulse using first 10 fourier coefficients')
ylabel('Amplitude') 
xlabel('Time')
legend({'Original','Estimation'},'Location','southwest')
hold off



