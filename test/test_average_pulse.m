% Tests and plots the PPG pulse splitting procedure

[ppg_signal, timestamps] = read_ppg_signal("data/young-athletic/5_raw.csv");

ppg_signal = preprocess_ppg_signal(-ppg_signal, timestamps);
pulse = average_pulse(ppg_signal);

clf('reset');

plot(pulse);

title('Averaging the pulses of a PPG signal');
ylabel('Amplitude');
xlabel('Time');