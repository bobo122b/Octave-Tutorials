% Question 4
clear; close all;

fc = 200;
dt = 1e-4;
t  = 0 : dt : (100-dt);
N  = length(t);

m  = besselj(0,t) .* cos(2*pi*10*t);
%plot(t, m); grid on;
%title('m(t)', 'fontsize', 20);

% a) plot spectrum of m(t)
fs = 1/dt;
df = 1/(N*dt);
if rem(length(t),2) == 0 % even
  f = (-0.5*fs) : df : (0.5*fs-df);
else % odd
  f = (-0.5*fs+0.5*df) : df : (0.5*fs-0.5*df);
end
M  = fftshift(fft(m))/N;
plot(f,abs(M)); grid on;
title('M(f)', 'fontsize', 20);

% b) determine BW (99% of signal power)

E = sum(abs(M.^2))/df;
index = find(f == 0);
j = 0;
W = 0;
while(sum(abs(M(index-j : index+j).^2))/df < 0.99*E)
  W = W + df;
  j = j + 1;
end
BW = 2*W;
fprintf('Bandwidth = %dHz\n', BW);

% c) find appropriate filter to transmit only USB
c  = 2*cos(2*pi*fc*t); %multiplied by 2 to get the same result
vo = m.*c;
figure(2);
plot(t, vo); grid on;
title('v(t)', 'fontsize', 20);  

Vo = fftshift(fft(vo))/N;
figure(3);
plot(f, abs(Vo)); grid on;
title('V(f)', 'fontsize', 20);
% here we chose BPF from 200 to 220
H_BPF = abs(f) >= 200;
H_BPF(abs(f) >= 220) = 0;

% d) plot the spectrum of the modulated signal

S = Vo.*H_BPF;
figure(4);
plot(f, S); grid on;
title('S(t)', 'fontsize', 20);

% using a coherent detector
% e) plot the spectrum of the signal after the product modulator

s_received = ifft(ifftshift(S*N));
vn = s_received.*c;         % signal after product modulator
Vn = fftshift(fft(vn))/N;
figure(5);
plot(f, abs(Vn)); grid on;
title('after product modulator', 'fontsize', 20);

% f) choose cutoff frequency, plot signal after LPF, and original signal on same plot.
% we choose cutoff freq to be 20 hz

H_LPF = abs(f) < 20;
M_received = Vn.*H_LPF;
m_received = ifft(ifftshift(M_received*N));
figure(6);
plot(t, m_received); grid on;
hold on;
plot(t, m, '--r');
hold off;
title('received message vs original message', 'fontsize', 20);
legend('received', 'original');
