%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title: Project 1
% Filename: Tipton_EGR534_Project1.m 
% Author: Natalie Tipton
% Class: EGR 534
% Date: 10/15/19
% Instructor: Dr. Rhodes
% Description: This project reads in resting and exercise ECG data and
%   finds the QRS complex, t-wave, heart rate, and QT interval.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% load data
rest_orig = load('ECG_Flow_Subject2_Rest.txt')';             
exercise_orig = load('ECG_Flow_Subject2_Exercise.txt')';

%separate out ECG data
rest_orig = rest_orig(3, :) - mean(rest_orig(3, :));              
exercise_orig = exercise_orig(3, :) - mean(exercise_orig(3, :));

% apply gaussian smoothing to the data twice to eliminate some noise
rest = smoothdata(rest_orig);
exercise = smoothdata(exercise_orig);
rest_smooth = smoothdata(rest);
exercise_smooth = smoothdata(exercise);

fs = 400;   % sampling frequency

% bandpass filter the data
rest_filt = bandpass(rest_smooth, [5 15], fs);
exercise_filt = bandpass(exercise_smooth, [5 15], fs);

% find length of data
n_rest = length(rest_smooth);
n_exercise = length(exercise_smooth);

% create time vectors for resting and exercise data
t_rest = 0 : 1/fs: n_rest/fs;
t_rest(end) = [];
t_exercise = 0 : 1/fs: n_exercise/fs;
t_exercise(end) = [];

% for completion of pan-tomkins method:
% find derivative of resting data
dx = rest_filt(2:end) - rest_filt(1:end-1);
dt = t_rest(2:end) - t_rest(1:end-1);
v1_rest = dx./dt;

% create time vector for resting derivative
t_rest2 = t_rest;
t_rest2(end) = [];

% find derivative of derivative of resting data
dx = v1_rest(2:end) - v1_rest(1:end-1);
dt = t_rest2(2:end) - t_rest2(1:end-1);
v2_rest = dx./dt;

% adjust time vector again
t_rest2(end) = [];

% find derivative of exercise data
dx2 = exercise_filt(2:end) - exercise_filt(1:end-1);
dt2 = t_exercise(2:end) - t_exercise(1:end-1);
v1_exercise = dx2./dt2;

% create time vector for exercise derivative
t_exercise2 = t_exercise;
t_exercise2(end) = [];

% find deriative of derivative of exercise data
dx2 = v1_exercise(2:end) - v1_exercise(1:end-1);
dt2 = t_exercise2(2:end) - t_exercise2(1:end-1);
v2_exercise = dx2./dt2;

% adjust time vector again
t_exercise2(end) = [];

% square data to emphasize peaks
rest_exp = rest_filt .^ 2;
exercise_exp = exercise_filt .^2;

% find maximum of squared rest data
max_rest = max(rest_exp);

% find all large peaks in resting data and number of those peaks
[i, j]= find(rest_exp>(max_rest*.18));
len_rest = length(j);

% find all large peaks in pan-thomkins resting derivatives + # of them
max_pan_rest = max(v2_rest);
[k, l]= find(v2_rest>(max_pan_rest*.35));
len_pan_rest = length(l);

% find all large peaks in exercise data + # of them
max_exercise = max(exercise_exp);
[m,n]= find(exercise_exp>(max_exercise *.18));
len_exercise = length(n);

% find all large peaks in pan-thomkins exercise derivatives + # of them
max_pan_exercise = max(v2_exercise);
[o, p]= find(v2_exercise>(max_pan_exercise*.35));
len_pan_exercise = length(p);

% maximum difference between registered peak values to be considered
% part of the same peak
threshold  = 5;     
 
% divide peaks array by similar values, showing they're representing same peak
boundaries = [true, abs(diff(j)) > threshold, true] ;
group_rest = mat2cell(j, 1, diff(find(boundaries))) ;

boundaries = [true, abs(diff(n)) > threshold, true] ;
group_exercise = mat2cell(n, 1, diff(find(boundaries))) ;

boundaries = [true, abs(diff(l)) > threshold, true] ;
group_pan_rest = mat2cell(l, 1, diff(find(boundaries))) ;

boundaries = [true, abs(diff(p)) > threshold, true] ;
group_pan_exercise = mat2cell(p, 1, diff(find(boundaries))) ;

% find the average of each grouping of peaks to determine a single location
% for each peak
for x = 1:length(group_rest)
    peaks_rest(x,:) = mean([group_rest{x}]);
end

for x = 1:length(group_exercise)
    peaks_exercise(x,:) = mean([group_exercise{x}]);
end

for x = 1:length(group_pan_rest)
    peaks_pan_rest(x,:) = mean([group_pan_rest{x}]);
end

for x = 1:length(group_pan_exercise)
    peaks_pan_exercise(x,:) = mean([group_pan_exercise{x}]);
end

% format peaks array to be easier to work with
peaks_rest(:,2:end) = [];
peaks_rest = peaks_rest.';

% round up so that locations can be used as an index
peaks_rest = ceil(peaks_rest);

% remove all peaks that are negative, leaving only the QRS peak
neg = find(rest_smooth(peaks_rest(:)) < max(rest_smooth) * .2);
peaks_rest(neg) = [];

% repeat above 3 steps for exercise data
peaks_exercise(:,2:end) = [];
peaks_exercise = peaks_exercise.';
peaks_exercise = ceil(peaks_exercise);
neg = find(exercise_smooth(peaks_exercise(:)) < max(exercise_smooth) * .2);
peaks_exercise(neg) = [];

% repeat for pan-thomkins peaks for rest
peaks_pan_rest(:,2:end) = [];
peaks_pan_rest = peaks_pan_rest.';
peaks_pan_rest = ceil(peaks_pan_rest);

% every other pan-thomkins peak is a Q or S point
q_points_rest = peaks_pan_rest(1:2:end);
s_points_rest = peaks_pan_rest(2:2:end);

% repeat for pan-thomkins peaks for exercise
peaks_pan_exercise(:,2:end) = [];
peaks_pan_exercise = peaks_pan_exercise.';
peaks_pan_exercise = ceil(peaks_pan_exercise);
q_points_exercise = peaks_pan_exercise(1:2:end);
s_points_exercise = peaks_pan_exercise(2:2:end);

% refine location of the S point
for x = 1:length(q_points_rest)-1
    s_points_rest(x) = s_points_rest(x) + find(diff(rest_smooth(s_points_rest(x):q_points_rest(x+1)))>0,1,'first');
end

% based on S-point location, find the peak of the t-wave
for x = 1:length(q_points_rest)-1
    t_top_rest(x) = s_points_rest(x) + find(diff(rest_smooth(s_points_rest(x):q_points_rest(x+1))) < 0,1,'first');
end

% based on peak of the t-wave, find the end of the t-wave
for x = 1:length(q_points_rest)-1
    t_end_rest(x) = t_top_rest(x) + find(diff(rest_smooth(t_top_rest(x):q_points_rest(x+1))) > 0,1,'first');
end

% repeat above for exercise data
for x = 1:length(q_points_exercise)-1
    s_points_exercise(x) = s_points_exercise(x) + find(diff(exercise_smooth(s_points_exercise(x):q_points_exercise(x+1)))>0,1,'first');
end

for x = 1:length(q_points_exercise)-1
   % differ(x,:) = diff(exercise(s_points_exercise(5):q_points_exercise(6)));
    t_top_exercise(x) = s_points_exercise(x) + find(diff(exercise_smooth(s_points_exercise(x):q_points_exercise(x+1))) < 0,1,'first');
end

for x = 1:length(q_points_exercise)-1
    %differ(x,:) = diff(rest(s_points_rest(2):q_points_rest(3)));
    t_end_exercise(x) = t_top_exercise(x) + find(diff(exercise_smooth(t_top_exercise(x):q_points_exercise(x+1))) > 0.5,1,'first');
end

% find number of peaks for each of the four situations
len_rest = length(peaks_rest);
len_exericse = length(peaks_exercise);
len_pan_rest = length(peaks_pan_rest);
len_pan_exercise = length(peaks_pan_exercise);
      
% find distance between each resting QRS complex
for beat = 1:length(peaks_rest)-1
    PtoP_rest(beat) = peaks_rest(beat+1) - peaks_rest(beat);
end

% calculate and display average resting heart rate
avg_PtoP_rest = mean(PtoP_rest);
rate_rest = 60 / (avg_PtoP_rest / fs);
disp('Resting heart rate =');
disp(rate_rest);

% repeat above to find exercize heart rate
for beat = 1:length(peaks_exercise)-1
    PtoP_exercise(beat) = peaks_exercise(beat+1) - peaks_exercise(beat);
end

avg_PtoP_exercise = mean(PtoP_exercise);
rate_exercise = 60 / (avg_PtoP_exercise / fs);
disp('Exercising heart rate = ');
disp(rate_exercise)

% find each qt distance
for event = 1:length(t_end_rest)
    qt_rest(event) = t_end_rest(event) - q_points_rest(event);
end

% calculate and display average resting qt-interval
avg_qt_rest = mean(qt_rest);
qt_int_rest = (avg_qt_rest / fs);
disp('Rest qt-interval = ');
disp(qt_int_rest)

% repeat above to find exercize qt-interval
for event = 1:length(t_end_exercise)
    qt_exercise(event) = t_end_exercise(event) - q_points_exercise(event);
end

avg_qt_exercise = mean(qt_exercise);
qt_int_exercise = (avg_qt_exercise / fs);
disp('Exercise qt-interval = ');
disp(qt_int_exercise)

figure(1)
plot(t_rest,rest)
hold on
plot(t_rest(peaks_rest(:)), rest(peaks_rest(:)), 'o');
hold off;
title('Resting ECG with QRS complex event shown.');
xlabel('time (s)'); ylabel('Amplitude (mV)');

figure(2)
plot(t_exercise,exercise)
hold on
plot(t_exercise(peaks_exercise(:)), exercise(peaks_exercise(:)), 'o');
hold off;
title('Exercise ECG with QRS complex event shown.');
xlabel('time (s)'); ylabel('Amplitude (mV)');

figure(3)
plot(t_rest, rest)
hold on
plot(t_rest(t_end_rest(:)), rest(t_end_rest(:)), 'o');
plot(t_rest(q_points_rest(:)), rest(q_points_rest(:)), 'o');
hold off;
legend('ECG', 'T-Wave', 'Q-Point');
title('Resting ECG with Q-Point and end of T-wave shown.');
xlabel('time (s)'); ylabel('Amplitude (mV)');

figure(4)
plot(t_exercise, exercise)
hold on
plot(t_exercise(t_end_exercise(:)), exercise(t_end_exercise(:)), 'o');
plot(t_exercise(q_points_exercise(:)), exercise(q_points_exercise(:)), 'o');
hold off;
legend('ECG', 'T-Wave', 'Q-Point');
title('Exercise ECG with Q-Point and end of T-wave shown.');
xlabel('time (s)'); ylabel('Amplitude (mV)');

figure(5)
plot(t_rest2, v2_rest)
title('Resting Pan-Tompkins double derivative result');
xlabel('time (s)'); ylabel('Amplitude (mV)');

figure(6)
plot(t_exercise2, v2_exercise)
title('Exercise Pan-Tompkins double derivative result');
xlabel('time (s)'); ylabel('Amplitude (mV)');

