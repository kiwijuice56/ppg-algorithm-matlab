function [cosine_coefficients, sine_coefficients] = calculate_fourier_coefficients(ppg_pulse) 
%CALCULATE_FOURIER_COEFFICIENTS 
% Returns the real fourier coefficients of a preproccessed PPG pulse.

arguments
    ppg_pulse (1,:) double
end

% FFT returns the coefficients in complex form, but we can convert that
% into the real form (sin/cos) using Euler's identity
% https://en.wikipedia.org/wiki/Sine_and_cosine_transforms#Relation_with_complex_exponentials
fourier_transform = fft(ppg_pulse);
cosine_coefficients = real(fourier_transform);
sine_coefficients = -imag(fourier_transform);

end

