sampling_frequency = 50; % Hertz
cutoff_frequency = 1; % Hertz
resampling_scale = 4;


clf('reset');

hold on

% Calculate the score
ppg_signal1 = read_ppg_signal(readmatrix("data/good-nagpur/412-2.csv"), 4);
scores1 = score_ppg_signal(ppg_signal1);

ppg_signal2 = read_ppg_signal(readmatrix("data/young-athletic/5_raw.csv"), 4);
scores2 = score_ppg_signal(ppg_signal2);


% Plot individual points
scatter(ones(size(scores1)).*(1+(rand(size(scores1))-0.5)/10),scores1,'.', 'linewidth', 1)
scatter(ones(size(scores2)).*(0.2+1+(rand(size(scores2))-0.5)/10),scores2,'.', 'linewidth', 1)

boxplot(scores1);
boxplot(scores2,'Positions',1.2);

% update axes x-ticks and labels:
set(gca(),'XTick',[1 1.2],'XTickLabels',{'Unhealthy', 'Healthy'})
title('Cardiovascular Scores For Single Person (Pulses)')
ylabel('Score')

hold off
