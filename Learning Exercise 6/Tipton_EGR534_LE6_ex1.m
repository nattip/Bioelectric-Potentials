%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title: EGR 534 LE 6 Exercise 1
% Filename: Tipton_EGR534_LE3_ex1.m
% Author: Natalie Tipton
% Class: EGR 534
% Date: 10/29/19
% Instructor: Dr. Rhodes
% Description: This script finds the PSD of different types of signals
%   with different frequencies
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%% Exercise 1: 1, 2 %%%%%%%%%%%%%%%%%%%
freq_1 = 35;    %declare frequency of signal
fs_1 = 200;     %declare sampling frequency
N = 512;

t1 = 0:(1 / fs_1):3;                              %create time vector
f1 = 0:(fs_1 / N):(fs_1 / 2)-(fs_1 / N);          %create frequency vector

x1 = 2.5 * sin(freq_1 * 2 * pi * t1);       %create sin wave with amp=2.5V, f=35Hz
X1 = abs(fft(x1, N));                       %find magnitude of fourier transfofrm of signal
pow_1 = X1 .^ 2;

figure(1)                                       %create new figure
subplot(2,1,1)                                  %in first of 2 subplots
plot(t1, x1)                                    %plot signal against time
grid                                            %add grid
title({'2.5*sin(35*2*pi*t)', 'fs = 200 Hz'})    %add title
ylabel('Amplitude (V)')                         %label y axis
xlabel('Time (s)')                              %label x axis
subplot(2,1,2)                                  %in second of 2 subplots
plot(f1, pow_1(1:N/2))                          %plot FT against frequency
grid                                            %add grid
title('Magnitude Of Power')                     %add title
ylabel('Magnitude')                             %label y axis
xlabel('Frequency (Hz)')                        %label x axis

%%%%%%%%%%%%%%%%%%% Exercise 1: 3 %%%%%%%%%%%%%%%%%%%

freq_2a = 20;
freq_2b = 15;
fs_2 = 150;

t2 = 0:(1 / fs_2):3;
f2 = 0:(fs_2 / N):(fs_2 / 2)-(fs_2 / N);

%addition of 2V sin wave with f=20Hz and 3V sin wave with f=15 Hz
x2 = 2 * sin(freq_2a * 2 * pi * t2) + 3 * sin(freq_2b * 2 * pi * t2);
X2 = abs(fft(x2, N));
pow_2 = X2 .^ 2;

figure(2)
subplot(2,1,1)
plot(t2, x2)
grid                                     
title({'2*sin(20*2*pi*t) + 3*sin(15*2*pi*t)', 'fs = 200 Hz'})
ylabel('Amplitude (V)')
xlabel('Time (s)')
subplot(2,1,2)
plot(f2, pow_2(1:N/2))
grid                                     
title('Magnitude Of Power')
ylabel('Magnitude')
xlabel('Frequency (Hz)')

%%%%%%%%%%%%%%%%%%% Exercise 1: 4 %%%%%%%%%%%%%%%%%%%

freq_3 = 15;
fs_3 = 200;

t3 = 0:(1 / fs_3):3;
f3 = 0:(fs_3 / N):(fs_3 / 2)-(fs_3 / N);

shift = 90;

%unit triangle wave with f=15Hz
x3 = sawtooth(freq_3 * 2 * pi * t3);
X3 = abs(fft(x3, 512));
pow_3 = X3 .^ 2;

figure(3)
subplot(2,1,1)
plot(t3, x3)
grid                             
title({'15 Hz unit amplitude sawtooth wave', 'fs = 200 Hz'})
ylabel('Amplitude (V)')
xlabel('Time (s)')
subplot(2,1,2)
plot(f3, pow_3(1:N/2))
grid                                     
title('Magnitude Of Power')
ylabel('Magnitude')
xlabel('Frequency (Hz)')

%%%%%%%%%%%%%%%%%%% Exercise 1: 5 %%%%%%%%%%%%%%%%%%%

freq_4 = 15;
fs_4 = 200;

t4 = 0:(1 / fs_4):3;
f4 = 0:(fs_4 / N):(fs_4 / 2)-(fs_4 / N);

%unit square wave with f=15Hz
x4 = square(freq_4 * 2 * pi * t4);
X4 = abs(fft(x4, N));
pow_4 = X4 .^ 2;

figure(4)
subplot(2,1,1)
plot(t4, x4)
grid                                  
title({'15 Hz unit amplitude square wave', 'fs = 100 Hz'})
ylabel('Amplitude (V)')
xlabel('Time (s)')
subplot(2,1,2)
plot(f4, pow_4(1:N/2))
grid                                         
title('Magnitude Of Power')
ylabel('Magnitude')
xlabel('Frequency (Hz)')

%%%%%%%%%%%%%%%%%%% Exercise 1: 6 %%%%%%%%%%%%%%%%%%%

freq_5 = 70;
fs_5 = 100;

t5 = 0:(1 / fs_5):3;
f5 = 0:(fs_5 / N):(fs_5 / 2)-(fs_5 / N);

%2V sin wave with f=70Hz
x5 = 2 * sin(freq_5 * 2 * pi * t5);
X5 = abs(fft(x5, N));
pow_5 = X5 .^ 2;

% plots
figure(5)
subplot(2,1,1)
plot(t5, x5)
grid                                      
title({'2*sin(70*2*pi*t)', 'fs = 100 Hz'})
ylabel('Amplitude (V)')
xlabel('Time (s)')
subplot(2,1,2)
plot(f5, pow_5(1:N/2))
grid                                         
title('Magnitude Of Power')
ylabel('Magnitude')
xlabel('Frequency (Hz)')