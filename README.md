# PPG algorithm MATLAB
A collection of PPG analysis algorithms used in 
[a heart health visualizer app.](https://github.com/kiwijuice56/heart-health-visualizer)
MATLAB coder is used to convert these algorithms into C++ code, which is then
compiled alongside the app code.

## Guide
The app records a user's PPG signal by asking them to place their finger
on their phone's camera and sampling images at 60 Hz. Each image is then
converted into a PPG data point by summing the red channel across all pixels 
in the image. Note that the resulting PPG signal will be flipped vertically,
so each point must be negated.

The algorithms in this repository accept a "raw" PPG signal as described above
as well as the timestamps in milliseconds. Before any analysis, the signal
must be preprocessed by `preprocess_ppg_signal`, which normalizes the signal
and resamples it to 150 Hz. The rest of the algorithms in this app omit 
timestamps because the preprocessed signal is guaranteed to be sampled
at even intervals.

Some functions in this repository accept individual pulses, which can
be attained via `helper/split_ppg_signal`. Note that although the 
PPG signal is preprocessed, the resulting PPG pulses are not -- before
any analysis, each pulse must also be preprocessed via `preprocess_ppg_pulse`,
which normalizes each pulse and resamples it to a fixed count of 500 samples.

### Functions

#### `helper/calculate_fourier_coefficients`
Returns the real fourier coefficients of a preproccessed PPG pulse.

#### `helper/find_pulse_points`
Find the major anatomy points of a processed PPG pulse (the systolic peak,
the diastolic peak, and the dicrotic notch).

#### `helper/read_ppg_signal`
Given the .csv path of a signal, return the raw time and data arrays.
This is only used for MATLAB testing, since the heart health visualizer 
app is responsible for saving and loading PPG signals.

#### `helper/smooth`
Returns a smoothed and unshifted signal.

#### `test/*`
Contains scripts used for testing and visualizing the results of 
the functions and algorithms in this repository. Each script requires
some data to work properly, which can be loaded via `helper/read_ppg_signal`.

#### `score_ppg_signal_fourier`
Returns the health scores of all pulses in a preprocessed
PPG signal. See [this slide deck](https://drive.google.com/file/u/3/d/1pe0JXUnOhZpmCMGCEVop8Zxzz9kD3FCD/view) 
for complete details on this algorithm, developed by Shreya Kumar.

#### `score_ppg_signal_linear_slope`
Returns the health scores of all pulses in a preprocessed
PPG signal. See Victoria Ouyang's thesis for details -- this algorithm 
calculates the slope of the rising edge of each pulse.

#### `score_ppg_signal_peak_detection`
Returns the health scores of all pulses in a preprocessed
PPG signal. Uses peak detection to find position of dicrotic notch relative 
to the diastolic and systolic peaks.

#### `score_ppg_signal_peak_detection`
Returns the health scores of all pulses in a preprocessed
PPG signal. See Victoria Ouyang's thesis for details -- this algorithm 
calculates the area under the rising edge curve.

## Sources
- Shreya Kumar: fourier coefficient scoring algorithm
- Victoria Ouyang: linear slope and rising edge area algorithms