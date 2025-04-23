function [cosine_coefficients, sine_coefficients] = calculate_fourier_coefficients(ppg_signal) %#codegen
%CALCULATE_FOURIER_COEFFICIENTS Returns the real fourier coefficients of a given PPG pulse, must be preprocessed

arguments
    ppg_signal (1,:) double
end

% FFT returns the coefficients in complex form, but we can convert that
% into the real form (sin/cos) using Euler's identity
% https://en.wikipedia.org/wiki/Sine_and_cosine_transforms#Relation_with_complex_exponentials
fourier_transform = fft(ppg_signal);
cosine_coefficients = real(fourier_transform);
sine_coefficients = -imag(fourier_transform);

end

