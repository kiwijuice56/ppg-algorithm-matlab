function [processed_ppg_signal] = read_ppg_signal(ppg_matrix, resampling_scale)
%READ_PPG_SIGNAL Given the data matrix read from a .csv file, return the
%ppg signal interpolated and preprocessed

arguments
    ppg_matrix (:,4) double
    resampling_scale (1,1) double
end

% Interpolate using cubic interpolation
time = linspace(ppg_matrix(1, 1), ppg_matrix(length(ppg_matrix), 1), ...
    resampling_scale * length(ppg_matrix));
ppg_signal = interp1(ppg_matrix(:, 1), ppg_matrix(:, 2), time, 'pchip');

% Invert to correct orientation
processed_ppg_signal = -ppg_signal;

end

