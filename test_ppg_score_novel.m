
[ppg_signal, timestamps] = read_ppg_signal("data/young-athletic/5_raw.csv");
%[ppg_signal, timestamps] = read_ppg_signal("data/good-nagpur/402-2.csv");

processed_ppg_signal = preprocess_ppg_signal(-ppg_signal, timestamps);


% Preprocess signal and split it into pulses
[~, indices] = split_ppg_signal(processed_ppg_signal);

% Calculate scores of all pulses

hold on
scores = zeros(length(indices) - 1, 1);
for i=1:length(indices) - 1 
    pulse = processed_ppg_signal(indices(i) : indices(i + 1));
    pulse = preprocess_ppg_pulse(pulse);
    
    % First, smooth the pulse heavily to reduce any noise
    pulse = smooth(pulse, 50);
    
    % Next, calculate the first derivative and smoothen it as well
    dy = gradient(pulse);    
    dy = smooth(dy, 30);
    
    % Calculate the peaks (since a pulse with a dicrotic notch will have
    % a peak in the first derivative after the first)
    [~, pulse_indices] = findpeaks(dy);
    
    plot(dy);
    plot(pulse_indices, dy(pulse_indices),'*r')

    % Calculate the pulse score as the ratio between the second and first 
    % peaks in the first derivative
    scores(i) = 0;
    if length(pulse_indices) > 1
        scores(i) = dy(pulse_indices(2)) / dy(pulse_indices(1));
    end
end

score = median(scores)

hold off

