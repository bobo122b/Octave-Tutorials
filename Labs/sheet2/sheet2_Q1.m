% Question 1
fm = 100;     %modulating frequency
fc = 10e3;    %carrier frequency
dt = 0.000001;
N  = 20e3;    %to go until t = 0.02s

% a) plot the baseband signal and the modulated signal vs time;
t = 0 : dt : (N-1)*dt;
y = cos(2*pi*fm*t);
figure(1);
plot(t, y); grid on;
title('Baseband signal', 'fontsize', 20);

c = cos(2*pi*fc*t);
figure(2);
plot(t, c); grid on;
title('carrier signal', 'fontsize', 20);

s = y.*c;
figure(3)
plot(t, s); grid on;
title('modulated signal', 'fontsize', 20);

% b) plot the spectrum of the baseband signal and the modulated signal
fs = 1 / dt;
df = 1 / (N*dt);
f  = (-0.5*fs) : df : (0.5*fs-df);

y_fft = fft(y);
y_fftshift = fftshift(y_fft)/N;
figure(4);
plot(f, abs(y_fftshift));
title('baseband spectrum', 'fontsize', 20);

s_fft = fft(s);
s_fftshift = fftshift(s_fft)/N;
figure(5);
plot(f, abs(s_fftshift));
title('modulated signal spectrum', 'fontsize', 20);

% c) repeat with fc = 0.5khz and fm = 10 hz
% we will change fm to 10, fc to 0.5e3, dt to 0.0001, and N to 5e3
