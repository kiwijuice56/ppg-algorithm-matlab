% Eyeball a single heartbeat.
% TODO: replace with routine to find average PPG signal 
raw_ppg_data = readmatrix("example_ppg_camera.csv");
ppg_pulse = raw_ppg_data(44:74,:);

% Resample the pulse to a higher rate to increase resolution,
% using cubic spline interpolation.
resampling_scale = 32;
time = linspace(ppg_pulse(1, 1), ppg_pulse(length(ppg_pulse), 1), resampling_scale * length(ppg_pulse));
ppg_value = interp1(ppg_pulse(:, 1), ppg_pulse(:, 2), time, 'pchip');

% Calculate the fourier transform + coefficients.

% FFT returns the coefficients in complex form, but we can convert that
% into the real form (sin/cos) using Euler's identity. 
% https://en.wikipedia.org/wiki/Sine_and_cosine_transforms#Relation_with_complex_exponentials
fourier_transform = fft(ppg_value);
cosine_coefficients = real(fourier_transform);
sine_coefficients = -imag(fourier_transform);

cosine_coefficients = abs(cosine_coefficients);
cosine_coefficients = cosine_coefficients / sum(cosine_coefficients);
expected_value_cosine = 
sum(cosine_coefficients)




