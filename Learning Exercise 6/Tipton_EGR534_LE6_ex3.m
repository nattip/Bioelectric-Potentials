%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title: EGR 534 LE 6 Exercise 3
% Filename: Tipton_EGR534_LE3_ex3.m
% Author: Natalie Tipton
% Class: EGR 534
% Date: 10/29/19
% Instructor: Dr. Rhodes
% Description: This script finds and plots the FFT and Power of ECG data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rest = load('ECG_Flow_Subject2_Rest.txt')';             % load data
exercise = load('ECG_Flow_Subject2_Exercise.txt')';

% separate out ECG data and zero-mean it 
rest = rest(3, :) - mean(rest(3, :));                       
exercise = exercise(3, :) - mean(exercise(3, :));

fs = 400;                   % sampling frequency used = 400
N = 2048;                   % number of points used for fft
n_rest = length(rest);              % find size of both datas
n_exercise = length(exercise);

% create time vectors for resting and exercise data
t_rest = 0 : 1/fs: n_rest/fs - 1/fs;
t_exercise = 0 : 1/fs: n_exercise/fs - 1/fs;

% create frequency vectors for both sets of data
f_rest = 0 : fs/N : (fs/2) - (fs/N);
f_exercise = 0 : fs/N : (fs/2) - (fs/N);

% find power of resting data
rest_f = abs(fft(rest, N));
pow_rest = rest_f .^ 2;

% find power of exercise data
exercise_f = abs(fft(exercise, N));
pow_exercise = exercise_f .^ 2;

% find derivative and power of that for resting data
dx_r = rest(2:end) - rest(1:end-1);
dt_r = t_rest(2:end) - t_rest(1:end-1);
v_rest = dx_r./dt_r;
v_rest_f = abs(fft(v_rest, N));
pow_v_rest = v_rest_f .^ 2;

% find derivative and power of that for exercise data
dx_e = exercise(2:end) - exercise(1:end-1);
dt_e = t_exercise(2:end) - t_exercise(1:end-1);
v_exercise = dx_r./dt_r;
v_exercise_f = abs(fft(v_exercise, N));
pow_v_exercise = v_exercise_f .^ 2;

% plot results of resting data (raw data, PSE, and PSE of derivative)
figure(1)
subplot(3,1,1)
plot(t_rest, rest)
title('Resting ECG Data'); xlabel('time (s)'); ylabel('Amplitude (mV)');
subplot(3,1,2)
plot(f_rest, pow_rest(1:N/2))
title('Power of resting data'); xlabel('frequency (Hz)'); ylabel('Amplitude');
xlim([0 100])
subplot(3,1,3)
plot(f_rest, pow_v_rest(1:N/2));
title('Power of derivative of resting data'); xlabel('frequency (Hz)'); ylabel('Amplitude');

% plot results of exercise data (raw data, PSE, and PSE of derivative)
figure(2)
subplot(3,1,1)
plot(t_exercise, exercise)
title('Exercise ECG Data'); xlabel('time (s)'); ylabel('Amplitude (mV)');
subplot(3,1,2)
plot(f_exercise, pow_exercise(1:N/2))
title('Power of exercise data'); xlabel('frequency (Hz)'); ylabel('Amplitude');
xlim([0 100]);
subplot(3,1,3)
plot(f_exercise, pow_v_exercise(1:N/2));
title('Power of derivative of exercise data'); xlabel('frequency (Hz)'); ylabel('Amplitude');
