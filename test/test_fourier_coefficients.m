% Tests and plots the fourier coefficient procedure

% Data measured in ms
[ppg_signal, timestamps] = read_ppg_signal("data/example_ppg_camera.csv");
ppg_signal = preprocess_ppg_signal(ppg_signal, timestamps);

% Find a single pulse
[~, indices] = split_ppg_signal(ppg_signal);
ppg_signal = ppg_signal(indices(3) : indices(4)); % Pick an arbitrary pulse

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

clf('reset');

hold on;

plot(ppg_signal)
plot(recreated_signal)
title('Estimating a PPG pulse using first 10 fourier coefficients')
ylabel('Amplitude') 
xlabel('Time')
legend({'Original','Estimation'},'Location','southwest')

hold off;
