% Data measured in ms
raw_ppg_data = readmatrix("data/example_ppg_camera.csv");
ppg_pulse = raw_ppg_data(:,:);
sampling_frequency = 50; % Hertz

% Resample the pulse to a higher rate to increase resolution,
% using cubic spline interpolation
resampling_scale = 4;
time = linspace(ppg_pulse(1, 1), ppg_pulse(length(ppg_pulse), 1), resampling_scale * length(ppg_pulse));
ppg_signal = interp1(ppg_pulse(:, 1), ppg_pulse(:, 2), time, 'pchip');

% Find a single pulse
cutoff_frequency = 1; % Hertz
indices = split_ppg_signal(ppg_signal, sampling_frequency, cutoff_frequency);
ppg_signal = ppg_signal(indices(2) : indices(3)); % Pick an arbitrary pulse

% Preprocess PPG pulse
ppg_signal = preprocess_ppg_pulse(ppg_signal);

% Calculate the fourier transform + coefficients
[cosine_coefficients, sine_coefficients] = calculate_fourier_coefficients(ppg_signal);

% Test: recreate signal using first few coefficients

recreated_signal = zeros(length(ppg_signal), 1);

coefficient_count = 10;

for x=1:1:length(ppg_signal)
    time_ratio = x / length(ppg_signal);
    recreated_signal(x) = sine_coefficients(1);
    for n=1:1:coefficient_count
        sine_term   = sine_coefficients(n + 1)   * sin(2 * pi * time_ratio * n);
        cosine_term = cosine_coefficients(n + 1) * cos(2 * pi * time_ratio * n);
        
        recreated_signal(x) = recreated_signal(x) + cosine_term + sine_term;
    end
end

recreated_signal = preprocess_ppg_pulse(recreated_signal);

% Plot original + recreation

cla reset;

hold on;

plot(ppg_signal)
plot(recreated_signal)
title('Estimating a PPG pulse using first 10 fourier coefficients')
ylabel('Amplitude') 
xlabel('Time')
legend({'Original','Estimation'},'Location','southwest')

hold off;
