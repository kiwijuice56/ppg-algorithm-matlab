clf('reset');

hold on

% Calculate the scores of two signals
% Patient 407 is CAD while 416 is healthy
[ppg_signal1, timestamps1] = read_ppg_signal("data/good-nagpur/407-2.csv");
scores1 = score_ppg_signal_fourier(preprocess_ppg_signal(ppg_signal1, timestamps1), 20);

[ppg_signal2, timestamps2] = read_ppg_signal("data/good-nagpur/407-1.csv");
scores2 = score_ppg_signal_fourier(preprocess_ppg_signal(ppg_signal2, timestamps2), 20);

[ppg_signal3, timestamps3] = read_ppg_signal("data/good-nagpur/416-1.csv");
scores3 = score_ppg_signal_fourier(preprocess_ppg_signal(ppg_signal3, timestamps3), 20);

[ppg_signal4, timestamps4] = read_ppg_signal("data/good-nagpur/416-2.csv");
scores4 = score_ppg_signal_fourier(preprocess_ppg_signal(ppg_signal3, timestamps3), 20);


% Plot individual points for the pulses in each signal
scatter(ones(size(scores1)).*(1+(rand(size(scores1))-0.5)/10),scores1,'.', 'linewidth', 1)
scatter(ones(size(scores2)).*(0.2+1+(rand(size(scores2))-0.5)/10),scores2,'.', 'linewidth', 1)
scatter(ones(size(scores3)).*(0.4+1+(rand(size(scores3))-0.5)/10),scores3,'.', 'linewidth', 1)
scatter(ones(size(scores4)).*(0.6+1+(rand(size(scores4))-0.5)/10),scores4,'.', 'linewidth', 1)

boxplot(scores1);
boxplot(scores2,'Positions',1.2);
boxplot(scores3,'Positions',1.4);
boxplot(scores4,'Positions',1.6);

% Update axes x-ticks and labels
set(gca(),'XTick',[1 1.2, 1.4, 1.6],'XTickLabels',{'CAD Patient (trial 1)', 'CAD Patient (trial 2)', 'Healthy Patient (trial 1)', 'Healthy Patient (trial 2)'})
title('Cardiovascular Scores For Single Person (Pulses)')
ylabel('Score')

hold off
