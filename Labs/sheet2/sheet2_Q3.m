% Question 3
% m(t) = J0(t) ,   0 < t < 10  (Non-periodic)
clear; close all;
% a) plot m(t) and its corresponding spectrum

t  = linspace(0,10, 100001);  % time vector

m  = besselj(0, t); 
% besselj(neo, beta) -> bessel function of first king with order neo and parameter Beta
plot(t, m); grid on;
title('m(t)', 'fontsize', 20);

% frequency domain
M_fft = fft(m);
M_fftshift = fftshift(M_fft)/length(t);

fs = 1 / (t(2)-t(1));    % maximum frequency
% we're using t(2)-t(1) to calculate the step (we can define it in a variable and call it dt)
df = 1 / (length(t)*(t(2)-t(1)));
if (rem(length(t), 2) == 0)   % if t array is even
  f = linspace(-0.5*fs,0.5*fs-df,length(t));
else  % if t array is odd
  f = linspace(-0.5*fs+0.5*df, 0.5*fs-0.5*df, length(t));
end
figure(2);
stem(f, abs(M_fftshift)); grid on;  % stem(x, y) plots as discrete signal
title('M(f)', 'fontsize', 20);

% b) Verify Parseval’s law, by calculating the signal total power in time domain andfrequency domain.

E_t = trapz(m.^2)/length(t);         % E_t is energy evaluated in time domain
E_f = trapz(abs(M_fftshift).^2);     % E_f is energy evaluated in freq domain
% trapz(x(t)) evaluates numerical integral
fprintf('Energy calculated in time domain = %.4f\nEnergy calculated in freq domain = %.4f\n', E_t, E_f);

% c) Determine BW (contains 99% of signal power)

W = 0;   % Bandwidth starts as the whole frequency of the signal
j  = 0;
index_i = find(f == 0);
while (trapz(abs(M_fftshift(index_i-j : index_i+j).^2)) < 0.99*E_f)
  j = j + 1;
  W = W + df;
end
BW = 2*W;
fprintf('Bandwidth = %d\n', BW);

% d) choose appropriate fc and ka

% fc is arbitrary but has to be > BW
fc = 1e3;
c  = cos(2*pi*fc*t);
% 1 + ka*m(t) must be > 0
% ka*m(t) > -1
% we can choose ka by putting the minimum value of m(t) (worst case)
ka = -1/min(m);

% d) Plot time domain of signal s(t)

s  = (1 + ka*m).*c;
figure(3);
plot(t, s); grid on;
title('s(t)', 'fontsize', 20);

% f) Plot spectrum of s(t)

S_fft = fft(s);
S_fftshift = fftshift(S_fft)/length(t);
figure(4);
stem(f, abs(S_fftshift)); grid on;
title('S(f)', 'fontsize', 20);

% g) using ideal envelope detector, compare output signal with m(t)

m_received = abs(hilbert(s));
% hilbert(x(t)) is in signal package
% hilbert(x(t)) takes a function and performs hilbert transform on it which returns its envelope
figure(5)
plot(t, m_received);
hold on
plot(t, m, '--r');
hold off
grid on;
title('received message vs sent message', 'fontsize', 20);
legend('received message', 'sent message');
