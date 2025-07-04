function [ppg_signal, timestamps] = read_ppg_signal(path)
%READ_PPG_SIGNAL Given the .csv path of a signal, return the raw time and data arrays.
%This is only used for MATLAB testing, since the app is responsible for 
%saving and loading PPG signals itself.

arguments
    path string
end

data_matrix = readmatrix(path);
timestamps = int64(data_matrix(:, 1));
ppg_signal = data_matrix(:, 2);

end

