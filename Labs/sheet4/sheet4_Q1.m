% Question 1
% FM transmitter
clear; close all;
fm = 100;
fc = 10e3;
kf = 10;
% Am = 1;

dt = 0.01*1/fc;
T  = 2/fm;
t  = 0 : dt : (T-dt);

% a) plot baseband and modulated signal

m  = cos(2*pi*fm*t);
plot(t, m); grid on;
title('baseband signal', 'fontsize', 20);

s  = cos(2*pi*fc*t + 2*pi*kf*cumtrapz(t,m));
figure(2);
plot(t, s); grid on;
title('modulated signal', 'fontsize', 20);

% b) plot the spectrum
fs = 1 / dt;
df = 1 / T;

if (rem(length(t),2)==0)
  f = -0.5*fs : df : (0.5*fs-df);
else
  f = (-0.5*fs - 0.5*df) : df : (0.5*fs+0.5*df);
end

M  = fftshift(fft(m))/length(t);
figure(3);
plot(f, abs(M)); grid on;
title('baseband spectrum', 'fontsize', 20);

S  = fftshift(fft(s))/length(t);
figure(4);
plot(f, abs(S)); grid on;
title('modulated spectrum', 'fontsize', 20);

% c) estimate BW
% Carson's
delf = max(kf*m);

BW_carson = 2*delf + 2*fm;
beta = delf/fm;
