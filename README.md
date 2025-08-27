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

### `helper/`
Contains helper functions used in multiple analysis algorithms
#### `calculate_fourier_coefficients`
Returns the real fourier coefficients of a preproccessed PPG pulse.

#### `find_pulse_points`


## Sources
- Shreya Kumar: fourier coefficient scoring algorithm
- Victoria Ouyang: linear slope and rising edge area algorithms