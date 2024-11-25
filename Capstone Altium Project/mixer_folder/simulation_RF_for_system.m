f_start = 1.6e9;        % Starting frequency of chirp (1.6 GHz)
f_end = 3.2e9;          % Ending frequency of chirp (3.2 GHz)
pulse_width = 1000e-6;   % Total duration of chirp (1000 microseconds)
fs = 1e10;              % Sampling rate (10 GHz for high resolution)
t = 0:1/fs:pulse_width; % Generate the time vector based on sampling rate
t_delay = 11.7e-9;        % Delay time for the second chirp (10 nanoseconds)

% Generate the original chirp signal (linear frequency modulation from 1.6 GHz to 3.2 GHz)
chirp_signal = sin(2 * pi * (f_start * t + (f_end - f_start) .* t.^2 / (2 * pulse_width)));

% Generate the delayed chirp signal starting at 1.6 GHz after 11.7 ns
t_delayed = t - t_delay; % Adjust time for delay
delayed_chirp_signal = sin(2 * pi * (f_start * t_delayed + (f_end - f_start) .* t_delayed.^2 / (2 * pulse_width)));
delayed_chirp_signal(t < t_delay) = 0; % Set values before delay to 0

% Multiply the original chirp signal with the delayed chirp signal
mixer_output = chirp_signal .* delayed_chirp_signal;

% Perform FFT to analyze frequency components of the mixer output
N = length(mixer_output);            
fft_mixer_output = fft(mixer_output); 
frequencies = linspace(0, fs/2, N/2); % Frequency axis for plotting


figure;
subplot(5, 1, 1);
plot(t, chirp_signal);
xlabel('Time (s)');
ylabel('Amplitude');
title('Original Chirp Signal (1.6 GHz to 3.2 GHz)');
grid on;

subplot(5, 1, 2);
plot(t, delayed_chirp_signal);
xlabel('Time (s)');
ylabel('Amplitude');
title('Delayed Chirp Signal (Starts at 1.6 GHz After 10 ns)');
grid on;

subplot(5, 1, 3);
plot(t, mixer_output);
xlabel('Time (s)');
ylabel('Amplitude');
title('Mixer Output (Product of Two Chirp Signals)');
grid on;

subplot(5, 1, 4);
plot(frequencies / 1e6, abs(fft_mixer_output(1:N/2)));
xlabel('Frequency (MHz)');
ylabel('Magnitude');
title('FFT of Mixer Output (MHz IF Frequency)');
grid on;

