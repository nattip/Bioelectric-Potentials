%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title: EGR 534 LE 6 Exercise 2
% Filename: Tipton_EGR534_LE3_ex2.m
% Author: Natalie Tipton
% Class: EGR 534
% Date: 10/29/19
% Instructor: Dr. Rhodes
% Description: This script finds the PSD of summed frequencies
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fs = 100;                           %declare sampling frequency        
t = 0:1/fs:6;                       %create time vector
f = 0:(fs/512):(fs/2)-(fs/512);     %create frequency vector

%%%%%%%%%%%%%%%%%%% Exercise 2: 1, 2 %%%%%%%%%%%%%%%%%%%
x1 = 0;     %initialize signal to 0

for k = 1:1
    x1 = x1 + (4 / (pi * k) * sin(2 * pi * k * t));     %create signal with 1 sin wave
end

X1 = abs(fft(x1, 512));     %find magnitude of fourier transfofrm of signal

figure(1)                                       %create new figure
subplot(2,1,1)                                  %in first of 2 subplots
plot(t,x1)                                      %plot signal against time
grid                                            %add grid
title({'x(t) = 4/(pi*k)*sin(2*pi*k*t)','k = 1'}) %add title
ylabel('Amplitude (V)')                         %label y axis
xlabel('Time (s)')                              %label x axis
subplot(2,1,2)                                  %in second of 2 subplots
plot(f,X1(1:256))                               %plot FT against frequency
grid                                            %add grid
title('Magnitude Of Power')          %add title
ylabel('Magnitude')                             %label y axis
xlabel('Frequency (Hz)')                        %label x axis

%%%%%%%%%%%%%%%%%%% Exercise 2: 3 %%%%%%%%%%%%%%%%%%%
x2 = 0;

%create signal with 2 sin waves
for k = 1:2:3
    x2 = x2 + (4 / (pi * k) * sin(2 * pi * k * t));
end

X2 = abs(fft(x2, 512));     %find magnitude of fourier transfofrm of signal

figure(2)                                       %create new figure
subplot(2,1,1)                                  %in first of 2 subplots
plot(t, x2)                                     %plot signal against time
grid                                            %add grid
title({'x(t) = 4/(pi*k)*sin(2*pi*k*t)','k = 1,3'})    %add title
ylabel('Amplitude (V)')                         %label y axis
xlabel('Time (s)')                              %label x axis
subplot(2,1,2)                                  %in second of 2 subplots
plot(f, X2(1:256))                              %plot FT against frequency
grid                                            %add grid
title('Magnitude Of Power')          %add title
ylabel('Magnitude')                             %label y axis
xlabel('Frequency (Hz)')                        %label x axis

%%%%%%%%%%%%%%%%%%% Exercise 2: 4 %%%%%%%%%%%%%%%%%%%
x3 = 0;

%create signal with 4 sine waves
for k = 1:2:7
    x3 = x3 + (4 / (pi * k) * sin(2 * pi * k * t));
end

X3 = abs(fft(x3, 512));     %find magnitude of fourier transfofrm of signal

figure(3)                                       %create new figure
subplot(2,1,1)                                  %in first of 2 subplots
plot(t, x3)                                     %plot signal against time
grid                                            %add grid
title({'x(t) = 4/(pi*k)*sin(2*pi*k*t)','k = 1,3,5,7'})    %add title
ylabel('Amplitude (V)')                         %label y axis
xlabel('Time (s)')                              %label x axis
subplot(2,1,2)                                  %in second of 2 subplots
plot(f, X3(1:256))                              %plot FT against frequency
grid                                            %add grid
title('Magnitude Of Power')          %add title
ylabel('Magnitude')                             %label y axis
xlabel('Frequency (Hz)')                        %label x axis

%%%%%%%%%%%%%%%%%%% Exercise 2: 5 %%%%%%%%%%%%%%%%%%%
x4 = 0;

%create signal with 11 sine waves
for k = 1:2:19
    x4 = x4 + (4 / (pi * k) * sin(2 * pi * k * t));
end

X4 = abs(fft(x4, 512));     %find magnitude of fourier transfofrm of signal

figure(4)                                       %create new figure
subplot(2,1,1)                                  %in first of 2 subplots
plot(t, x4)                                     %plot signal against time
grid                                            %add grid
title({'x(t) = 4/(pi*k)*sin(2*pi*k*t)','k = 1-19, odd'})    %add title
ylabel('Amplitude (V)')                         %label y axis
xlabel('Time (s)')                              %label x axis
subplot(2,1,2)                                  %in second of 2 subplots
plot(f, X4(1:256))                              %plot FT against frequency
grid                                            %add grid
title('Magnitude Of Power')          %add title
ylabel('Magnitude')                             %label y axis
xlabel('Frequency (Hz)')                        %label x axis

