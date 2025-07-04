clf('reset');

hold on

% Calculate the scores of two signals
[ppg_signal1, timestamps1] = read_ppg_signal("data/good-nagpur/412-2.csv");
scores1 = score_ppg_signal(ppg_signal1, timestamps1);

[ppg_signal2, timestamps2] = read_ppg_signal("data/young-athletic/5_raw.csv");
scores2 = score_ppg_signal(ppg_signal2, timestamps2);


% Plot individual points for the pulses in each signal
scatter(ones(size(scores1)).*(1+(rand(size(scores1))-0.5)/10),scores1,'.', 'linewidth', 1)
scatter(ones(size(scores2)).*(0.2+1+(rand(size(scores2))-0.5)/10),scores2,'.', 'linewidth', 1)

boxplot(scores1);
boxplot(scores2,'Positions',1.2);

% Update axes x-ticks and labels
set(gca(),'XTick',[1 1.2],'XTickLabels',{'Unhealthy', 'Healthy'})
title('Cardiovascular Scores For Single Person (Pulses)')
ylabel('Score')

hold off
