% Tests and plots the PPG pulse splitting procedure

[ppg_signal, timestamps] = read_ppg_signal("data/young-athletic/1_raw.csv");

ppg_signal = preprocess_ppg_signal(ppg_signal, timestamps);
[smoothed_ppg_signal, indices] = split_ppg_signal(ppg_signal);

clf('reset');

figure;
subplot(1,2,1)
hold on;
plot(ppg_signal)
plot(smoothed_ppg_signal)
plot(indices, ppg_signal(indices),'*r')
hold off;

subplot(1,2,2)
hold on;
for i = 1:length(indices) - 1
    plot(preprocess_ppg_pulse(ppg_signal(indices(i) : indices(i + 1))))
end
hold off;


title('Splitting a PPG signal into its pulses');
ylabel('Amplitude');
xlabel('Time');