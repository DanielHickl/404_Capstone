f_signal1 = 25e6;       % Frequency of the first sine wave (25 MHz)
f_signal2 = 25e6;       % Frequency of the second sine wave (25 MHz)
fs = 1e9;               % Sampling rate (1 GHz for high resolution)
duration = 1e-3;        % Signal duration (1 millisecond)
t = 0:1/fs:duration;    % Time vector based on sampling rate and duration

% Step 1: Generate the first sine wave signal
signal1 = zeros(1, length(t)); % Initialize the first sine wave with zeros
for i = 1:length(t)
    % Compute the sine wave at each sample point
    signal1(i) = sin(2 * pi * f_signal1 * t(i));
end

% Step 2: Generate the second sine wave signal
signal2 = zeros(1, length(t)); % Initialize the second sine wave with zeros
for i = 1:length(t)
    % Compute the sine wave at each sample point
    signal2(i) = sin(2 * pi * f_signal2 * t(i));
end

% Step 3: Perform the mixer operation
% Multiply the two sine waves point-by-point
mixer_output = zeros(1, length(t)); % Initialize the mixer output
for i = 1:length(t)
    % Compute the product of the two sine wave signals
    mixer_output(i) = signal1(i) * signal2(i);
end

% Step 4: Analyze frequency components using FFT
N = length(mixer_output); % Number of points for FFT
fft_mixer_output = fft(mixer_output); % Perform FFT on the mixer output
frequencies = linspace(0, fs / 2, floor(N / 2)); % Generate frequency axis for plotting

% Step 5: Plot the first sine wave signal
figure; % Create a new figure for plotting
subplot(4, 1, 1); 
plot(t, signal1); % Plot the first sine wave
xlabel('Time (s)'); % Label the x-axis
ylabel('Amplitude'); % Label the y-axis
title('First Sine Wave (25 MHz)'); % Add a title
grid on; % Enable grid lines for better visualization

% Step 6: Plot the second sine wave signal
subplot(4, 1, 2); 
plot(t, signal2); 
xlabel('Time (s)'); 
ylabel('Amplitude'); 
title('Second Sine Wave (25 MHz)'); 
grid on; 

% Step 7: Plot the mixer output
subplot(4, 1, 3); 
plot(t, mixer_output);
xlabel('Time (s)'); 
ylabel('Amplitude'); 
title('Mixer Output (Product of Two 25 MHz Sine Waves)'); 
grid on; 

% Step 8: Plot the FFT of the mixer output
subplot(4, 1, 4); 
plot(frequencies / 1e6, abs(fft_mixer_output(1:floor(N / 2)))); 
xlabel('Frequency (MHz)'); 
ylabel('Magnitude');
title('FFT of Mixer Output'); 
grid on; 


