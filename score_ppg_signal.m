function [score] = score_ppg_signal(ppg_signal, sampling_frequency, cutoff_frequency)
%SCORE_PPG_SIGNAL Calculates a cardiovascular health score from a raw PPG
%signal
%   See https://drive.google.com/file/u/3/d/1pe0JXUnOhZpmCMGCEVop8Zxzz9kD3FCD/view

indices = split_ppg_signal(ppg_signal, sampling_frequency, cutoff_frequency);

scores = zeros(length(indices), 1);



for i=1:length(indices) - 1
    pulse = preprocess_ppg_pulse(ppg_signal(indices(i) : indices(i + 1)));
    if (length(pulse) < 20) 
        continue;
    end
    [cos_coef, sin_coef] = calculate_fourier_coefficients(pulse);
    scores(i) = sum(cos_coef(1:10)) + sum(sin_coef(1:10));
end

score = median(scores);%median(maxk(scores, 3));

end

