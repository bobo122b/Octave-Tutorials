clear;

%sin(2pi*f*t)
%f = 1
%N=1000
% Time domain
ts = 0.01;              %time step
N  = 1000;              %number of elements in t
t  = 0 : ts : (N-1)*ts; %1000 elements from 0 to 999 [0 0.01 0.02 0.03 ..]
y  = sin(2*pi*t);       %determines value of y for each element in t and saves them in an array in y
figure(1);              %to make a new figure
plot(t,y); 

% Frequency domain
%fft(x(t)) -> fourier transform of x(t) -> X(f)

X_fft = fft(y);
fs    = 1/ts;     %total frequency of the array of f
df    = 1/(N*ts); %df step for the frequency array

f     = (-0.5*fs):df:(0.5*fs-df); % ex: [-2 -1 0 1], since we want only N elements in our array
figure(2);
plot(f, abs(X_fft)/N); %abs(x) -> absolute / magnitude of x

%fftshift(x) ->takes argument X(f) which is the fourier transform of x(t), returns the fourier transform shifted around 0

X_fftshift = fftshift(X_fft)/N;  %divide by N because it's multiplied by the number of steps
figure(3);
plot(f, abs(X_fftshift));
