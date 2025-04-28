sampling_frequency = 50; % Hertz
cutoff_frequency = 1; % Hertz

scores = zeros(length(files), 2);

for i = 1:2
    directory = uigetdir; 
    files = dir(fullfile(directory,'*.csv')); 
    for k = 1:length(files)
        base_name = files(k).name;
        file_name = fullfile(directory, base_name);
        data = readmatrix(file_name);
        raw_ppg_signal = data(:,:);
        
        % Resample the pulse to a higher rate to increase resolution,
        % using cubic spline interpolation
        resampling_scale = 4;
        time = linspace(raw_ppg_signal(1, 1), ...
            raw_ppg_signal(length(raw_ppg_signal), 1), ...
            resampling_scale * length(raw_ppg_signal));
        ppg_signal = interp1(raw_ppg_signal(:, 1), raw_ppg_signal(:, 2), time, 'pchip');
        
        
        scores(k, i) = score_ppg_signal(ppg_signal, ...
            sampling_frequency * resampling_scale, ...
            cutoff_frequency * resampling_scale);
    end

end

hold on 

boxplot(scores, {'Young Athletic','Young Nonathletic'})
title('Cardiovascular Scores')
xlabel('Group')
ylabel('Score')

hold off
