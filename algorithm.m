% Eyeball a single heartbeat 
% TODO: replace with routine to find average PPG signal 
raw_ppg_data = readmatrix("example_ppg_camera.csv");
ppg_pulse = raw_ppg_data(44:74,:);

% Resample the pulse
resampling_scale = 100;
time = linspace(ppg_pulse(1, 1), ppg_pulse(length(ppg_pulse), 1), resampling_scale * length(ppg_pulse));
ppg_value = interp1(ppg_pulse(:, 1), ppg_pulse(:, 2), time, 'pchip');

plot(time, ppg_value)

