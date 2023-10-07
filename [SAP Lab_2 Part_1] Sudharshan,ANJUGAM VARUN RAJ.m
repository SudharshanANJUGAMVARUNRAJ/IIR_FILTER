%[SAP LAB_1} Sudharshan_ANJUGAM _VARUN RAJ, Muhammad Arshad_AHMED

%part_1:IIR filter as a noise cancelling filter'Don_Giovanni_1.wav'
%the audioread function is used to sample the original voice
[y, fs] = audioread('Don_Giovanni_1.wav'); % read audio signal and sample rate from file
y = y(:, 1); % extract first channel
y1 = fft(y, 2048); % compute FFT of audio signal
f = fs * (1:1024) / 2048; % define frequency axis for plotting
figure(1); % create figure 1
subplot(211); plot(y); % create subplot 1 in figure 1 and plot time-domain waveform
title('Time domain waveform of voice signal'); xlabel('Frequency'); ylabel('Amplitude');
subplot(212); plot(f(1:1024), abs(y1(1:1024))); % create subplot 2 in figure 1 and plot frequency-domain waveform
title('Frequency domain waveform of voice signal'); xlabel('Frequency'); ylabel('Amplitude');
fp1i = 1000; % define passband frequency (Hz)
fs1i = 1300; % define stopband frequency (Hz)
wp1i = 2 * pi * fp1i / fs; % convert passband frequency to radians/s
ws1i = 2 * pi * fs1i / fs; % convert stopband frequency to radians/s
Rp1i = 5; % define passband ripple (dB)
Rs1i = 50; % define stopband attenuation (dB)
Ts = 1/fs; % compute sampling period
Wp1i = 2/Ts * tan(wp1i/2); % apply bilinear transformation to convert analog filter specifications to digital
Ws1i = 2/Ts * tan(ws1i/2);
[N1i, Wn1i] = cheb1ord(Wp1i, Ws1i, Rp1i, Rs1i, 's'); % compute minimum filter order and cutoff frequency for Chebyshev type 1 LPF
[B1i, A1i] = cheby1(N1i, Rp1i, Wn1i, 's'); % compute filter coefficients for Chebyshev type 1 LPF
[bz1i, az1i] = bilinear(B1i, A1i, fs); % apply bilinear transformation to convert analog filter to digital
figure(2); % create figure 2
freqz(bz1i, az1i, 1024, fs); % plot frequency response of IIR LPF in figure 2
title('Frequency response of Chebyshev type 1 LPF'); % add title to figure 2
x1 = filter(bz1i, az1i, y); % apply IIR LPF to audio signal
sound(x1, fs); % play filtered audio signal
x2 = fft(x1, 2048); % compute FFT of filtered signal
f7 = fs * (1:1024) / 2048; % define frequency axis for plotting
figure(3); % create figure 3
subplot(211); plot(x1); % create subplot 1 in figure 3 and plot time-domain waveform of filtered signal
title('Time-domain waveform of speech signal after IIR low-pass filtering'); xlabel('Time'); ylabel('Amplitude');
subplot(212); plot(f7(1:1024), abs(x2(1:1024))); % create subplot 2 in figure 3 and plot frequency-domain waveform of filtered signal
title('Frequency-domain waveform of speech signal after IIR low-pass filtering'); xlabel('Frequency'); ylabel('Amplitude');