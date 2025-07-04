% Tests and plots the PPG pulse splitting procedure

[ppg_signal, timestamps] = read_ppg_signal("data/young-athletic/2_raw.csv");
[~, indices] = split_ppg_signal(ppg_signal);

clf('reset');

hold on;
for i = 1:length(indices) - 1
    plot(preprocess_ppg_pulse(ppg_signal(indices(i) : indices(i + 1))))
end
hold off;


title('Splitting a PPG signal into its pulses');
ylabel('Amplitude');
xlabel('Time');