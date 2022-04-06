% Question 3
% m(t) = J0(t)  0 < t < 10 (Non-periodic)
% bessel J(neo, t) -> appears in FM tranceiver
% J is a bessel function of first kind
clear; close all;
%t  = linspace(0, 10, 100001);  % time vector
%dt = t(2) - t(1);

dt = 1e-4;
N  = 100000;
t  = 0 : 1e-4 : (N-1)*dt;
m  = besselj(0, t);
m(t>=10) = 0;
% besselj(neo, beta) -> bessel function of first kind with order neo and parameter beta
% a) plot m(t) and its spectrum
% time domain
plot(t, m); grid on;
title('m(t)', 'fontsize', 20);

% frequency domain
M  = fftshift(fft(m))/N; % M -> freq domain of m

fs = 1 / dt;
df = 1 / (N*dt);

if (rem(length(t), 2) == 0) % even
  f = (-0.5*fs) : df : (0.5*fs-df);
else  % odd
  f = (-0.5*fs+0.5*df) : df : (0.5*fs-0.5*df);
end
figure(2);
stem(f, abs(M)); grid on;
title('M(f)', 'fontsize', 20);
% stem -> plots points with lines to zero

% b) verify Parselval's law

E_t = sum(abs(m.^2))*dt;
E_f = sum(abs(M.^2))/df;

fprintf('Energy calculated in time domain = %.4f\nEnergy calculated in freq domain = %.4f\n', E_t, E_f);

% C) calculate BW (contains 99% of signal power)
W = 0;    % width
index = find(f == 0);
j = 0;
while (sum(abs(M(index-j : index+j).^2))/df < 0.99*E_f)
  W = W + df;
  j = j + 1;
end
BW = 2 * W;
fprintf('Bandwidth = %d\n', BW);

% d) choose appropriate fc, ka
fc = 1e3; % carrier frequency
c  = cos(2*pi*fc*t);

% 1 + ka*m(t) > 0
% ka*m(t) > -1
ka = -1 / min(m);

% e) plot s(t) and check no reversal

s  = (1 + ka*m).*c;
figure(3);
plot(t, s); grid on;
title('s(t)', 'fontsize', 20);

% f) plot spectrum
S  = fftshift(fft(s))/N;
figure(4);
stem(f, abs(S)); grid on;
title('S(f)', 'fontsize', 20);

% g) using ideal envelope detector, compare output signal with msg
pkg load signal
% hilbert(x(t)) -> returns envelope of function

m_received = abs(hilbert(s));
plot(t, m_received);
hold on
plot(t, m, '--r');
hold off
grid on;
title('message received vs sent message', 'fontsize', 20);
legend('message received', 'message sent');
