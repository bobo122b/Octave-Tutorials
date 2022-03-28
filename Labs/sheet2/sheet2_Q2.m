% Question 2
clear;
fm = 100;  %modulating frequency
fc = 10e3; %carrier frequency
dt = 0.000001;
N  = 20e3;
t  = 0 : dt : (N-1)*dt;

% we first create our signal from the DSB-SC modulator
y  = cos(2*pi*fm*t);  %modulating signal
c  = cos(2*pi*fc*t);  %carrier signal
s  = y.*c;            %sent signal

figure(1)
plot(t, s); grid on;
title('sent signal in time', 'fontsize', 20);

% we then receive our signal on the coherent detector
v  = s.*c;
figure(2)
plot(t, v); grid on;
title('after product modulation', 'fontsize', 20);

% a) plot the spectrum of the signal after the product modulator
fs = 1/dt;
df = 1/(N*dt);
f  = (-0.5*fs):df:(0.5*fs-df);
v_fft = fft(v);
v_fftshift = fftshift(v_fft)/N;
figure(3)
plot(f, abs(v_fftshift)); grid on;
title('after product modulation in freq.', 'fontsize', 20);

% b) choose the cut-off frequency of the filter and plot the signal after the LPF vs time
% and plot the corresponding figures of the original baseband signal in the same figure.

% from a, we can choose the cutoff frequency to be 200Hz since it's an ideal filter
H = zeros(1, length(f));  % to make the frequency response of the ideal filter
for i = 1 : length(f)
  if (f(i) >= -200)       % since we've chosen the cut-off frequency to 200Hz
    if (f(i) <= 200)
      H(i) = 1;
    endif
  endif
end

vo_f = v_fftshift.*H;      % we multiply by the frequency response of the LPF

figure(4)
plot(f, abs(vo_f)); grid on;
title('after LPF', 'fontsize', 20);

% since we've removed some frequencies, we can only deal with the function in frequency domain
% so we want to return the function to the time domain, so first we do an ifftshift of the function
% and we multiply by N since we've divided by it in the fftshift at the beginning.
% then to go back to time domain, we make ifft which is inverse fourier transform.
vo_back = ifftshift(vo_f*N); 
vo_t = ifft(vo_back);

figure(5)
plot(t, vo_t); grid on;
hold on                 % to plot both on the same figure.
plot(t, y, '--r');  
title('received message', 'fontsize', 20);
hold off
legend('received message', 'original message')
