% Question 2
close all; clear;
fm = 100;
fc = 1e3;
kf = 10;
% Am = 1;
% Ac = 1;

dt = 0.001/fc;
T  = 2/fm;
t  = 0 : dt : (T-dt);

fs = 1 / dt;
df = 1 / T;
if rem(length(t),2) == 0
  f  = (-0.5*fs) : df : (0.5*fs-df);
else
  f  = (-0.5*fs-0.5*df) : df : (0.5*fs+0.5*df);
end

% a) design a NBFM transmitter, plot time domain and spectrum

% m(t) -> integrator*2*pi*kf -> *Ac*sin(2*pi*fc*t) -> +Ac*cos(2*pi*fc*t) -> s(t)
% s(t) = Ac*cos(2*pi*fc*t) + Ac*phi*sin(2*pi*fc*t)
% phi(t) = 2*pi*kf*integral(m(t))

m  = cos(2*pi*fm*t);
plot(t, m); grid on;
title('baseband signal', 'fontsize', 20);

M  = fftshift(fft(m))/length(t);
figure(2);
plot(f, abs(M)); grid on;
title('baseband spectrum', 'fontsize', 20);

% integrating
phi = cumtrapz(t,m) * 2*pi*kf;
figure(3);
plot(t, phi); grid on;
title('\phi(t)', 'fontsize', 20);

PHI = fftshift(fft(phi))/length(t);
figure(4);
plot(f, abs(PHI)); grid on;
title('\Phi(f)', 'fontsize', 20);

% multiplying by carrier
c1 = sin(2*pi*fc*t);
c2 = cos(2*pi*fc*t);
v  = phi.*c1;
figure(5);
plot(t, v); grid on;
title('v(t)', 'fontsize', 20);

V  = fftshift(fft(v))/length(t);
figure(6);
plot(f, abs(V)); grid on;
title('V(f)', 'fontsize', 20);

% adding carrier
s = v + c2;
figure(6);
plot(t, s); grid on;
title('s(t)', 'fontsize', 20);

S = fftshift(fft(s))/length(t);
figure(7);
plot(f, abs(S)); grid on;
title('S(f)', 'fontsize', 20);

% b) Design FM receiver (using ideal FM)
% s(t) -> differentiator -> envelope detector
s2 = sin(2*pi*fc*t+2*pi*kf*cumtrapz(t,m));
% receiver
x  = diff(s2)/dt;
pkg load signal
vn = abs(hilbert(x));
vn = vn - mean(vn);
figure(8);
plot(t(2:end)-0.5*dt, vn/max(vn)); grid on;
hold on; plot(t, m); hold off
