% Question 3
clear; close all;

% vout = vin + 0.5 vin^3 + vin^3
fm = 100;
fc = 1e3;
dt = 0.01/fc;
T  = 2/fm;
t  = 0 : dt : (T-dt);
df = 1 / T;
fs = 1 / dt;
m  = cos(2*pi*fm*t);
plot(t, m); grid on;
title('baseband signal', 'fontsize', 20);
if (rem(length(t),2)==0)
  f = (-0.5*fs) : df : (0.5*fs-df);
else
  f = (-0.5*fs-0.5*df) : df : (0.5*fs+0.5*df);
end

M = fftshift(fft(m))/length(t);
figure
plot(f, abs(M)); grid on;
title('baseband spectrum', 'fontsize', 20);
% a) AM: ka = 0.5
ka = 0.5
% s(t) = Ac*(1+ka*m(t))*cos(2*pi*fc*t)
% before channel
c = cos(2*pi*fc*t);
s_AM = (1 + ka*m).*c;
S_AM = fftshift(fft(s_AM))/length(t);

% after channel
v_AM = s_AM + 0.5*s_AM.^2 + s_AM.^3;
figure
plot(t, v_AM); grid on;
hold on
plot(t, s_AM); hold off;
title('AM signal after channel vs before channel', 'fontsize', 20);
V_AM = fftshift(fft(v_AM))/length(t);
figure
plot(f, abs(V_AM)); grid on;
hold on;
plot(f, abs(S_AM)); hold off;
title('AM spectrum after channel vs before channel', 'fontsize', 20);

% b) FM: kf = 10
kf = 10;
% s(t) = Af*cos(2*pi*fc*t + 2*pi*kf*integral(m(t)))
% before channel
s_FM = cos(2*pi*fc*t + 2*pi*kf*cumtrapz(t, m));
S_FM = fftshift(fft(s_FM))/length(t);

% after channel
v_FM = s_FM + 0.5*s_FM.^2 + s_FM.^3;
figure
plot(t, v_FM); grid on;
hold on
plot(t, s_FM); hold off;
title('FM signal after channel vs before channel', 'fontsize', 20);

V_FM = fftshift(fft(v_FM))/length(t);
figure
plot(f, abs(V_FM)); grid on;
hold on
plot(f, abs(S_FM)); hold off;
title('FM spectrum after channel vs before channel', 'fontsize', 20);
