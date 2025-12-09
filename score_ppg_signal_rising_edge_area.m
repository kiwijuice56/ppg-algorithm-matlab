function [scores] = score_ppg_signal_rising_edge_area(processed_ppg_signal)
%SCORE_PPG_RISING_EDGE_AREA
% Returns the health scores of all pulses in a preprocessed
% PPG signal (via preprocess_ppg_signal(raw, timestamps)). See Victoria
% Ouyang's thesis for details -- this algorithm calculates the area under
% the rising edge curve.
arguments
    processed_ppg_signal (1,:) double
end

% Split signal into pulses
indices = split_ppg_signal(processed_ppg_signal);

% Calculate scores of all pulses
scores = zeros(length(indices) - 1, 1);
for i=1:length(indices) - 1 
    pulse = preprocess_ppg_pulse(processed_ppg_signal(indices(i) : indices(i + 1)));
    [systolic_peak, ~, ~] = find_pulse_points(pulse);

    % Find the first derivative
    first_derivative = gradient(pulse);
    
    [~, first_derivative_peak_indices] = findpeaks(first_derivative);

    if isempty(first_derivative_peak_indices)
        scores(i) = 0;
    else
        % Find integration points
        starting_point = first_derivative_peak_indices(1);
        ending_point = max([starting_point, systolic_peak]);


        % Integral of second derivative (numerator) and original pulse (denominator)
        numerator = first_derivative(ending_point) - first_derivative(starting_point);
        denominator = sum(pulse(starting_point : ending_point));

        scores(i) = abs(numerator / denominator);
    end
end

end



