function [processed_ppg_signal] = preprocess_ppg_signal(ppg_signal, timestamps)
%PREPROCESS_PPG_SIGNAL Returns a processed copy of a raw PPG signal (red 
%channel values of a camera recording at the given timestamps, 
%in milliseconds). Assumes raw PPG signal has the correct orientation. 

arguments
    ppg_signal (1,:) double
    timestamps (1,:) int64
end

% Normalize and rescale to [0, 1] range
processed_ppg_signal = ppg_signal - mean(ppg_signal);
processed_ppg_signal = processed_ppg_signal ./ max(abs(processed_ppg_signal));

% Interpolate using cubic interpolation
new_sampling_frequency = 150; % Hz
recording_start = timestamps(1);
recording_end = timestamps(length(timestamps));
recording_length = (recording_end - recording_start) / 1000.0; % Milliseconds -> Seconds
new_sample_count = int64(new_sampling_frequency * recording_length);

scaled_timestamps = linspace(double(recording_start), double(recording_end), new_sample_count);
processed_ppg_signal = interp1(double(timestamps), processed_ppg_signal, scaled_timestamps, 'pchip');

% Detrend
processed_ppg_signal = detrend(processed_ppg_signal);

end

