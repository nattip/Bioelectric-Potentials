%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title: LE 2 Ex 1
% Filename: Tipton_LE2_ex1.m
% Author: Natalie Tipton
% Date: 9/3/19
% Instructor: Dr. Rhodes
% Description: This script looks at integral and DE calculations using
%   numerical methods to hand calculate and built in methods to 
%   calculate for you.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%% Exercise 2 a %%%%%%%%%%%%%%%%%%%
        
pre_ischemia = load('LVP_PreIschemia.txt')';        % load data
post_ischemia = load('LVP_PostIschemia.txt')';
[x,y] = size(pre_ischemia);                         % find size of data

t = linspace(0, 2.5, y);
h = t(1,2) - t(1,1);

figure(1)                                           % plot data
subplot(2,1,1)
plot(t, pre_ischemia)
title('Pre Ischemia LVP data over time')
xlabel('time (s)');
ylabel('LVP before ischemia');
subplot(2,1,2)
plot(t, post_ischemia)
title('Post Ischemia LVP data over time')
xlabel('time (s)');
ylabel('LVP after ischemia');

%pre-ischemia calculations
tic     %start timer
pre_deriv1 = zeros(0,y);        % allocate size
for i = 2:y-1
    pre_deriv1(1,i) = (pre_ischemia(1, i+1) - pre_ischemia(1, i-1)) / (2 * h);  % calculate 1st deriv
end

pre_deriv2 = zeros(0,y);        % allocate size
for i = 2:y-1
    pre_deriv2(1,i) = (pre_ischemia(1, i+1) - (2 * pre_ischemia(1, i)) + pre_ischemia(1, i-1)) / h^2;   % calculate 2nd deriv
end
toc     % end timer

tic     % start timer
pre_deriv1_diff = diff(pre_ischemia) ./ h;      % verify derivs with diff function
pre_deriv1_diff(1,305) = 0;

pre_deriv2_diff = diff(pre_deriv1_diff) ./ h;
pre_deriv2_diff(1, 305) = 0;
toc

%post ischemia calculationsf
post_deriv1 = zeros(0,y);   % allocate size
for i = 2:y-1
    post_deriv1(1,i) = (post_ischemia(1, i+1) - post_ischemia(1, i-1)) / (2 * h);   % calculate 1st deriv
end

post_deriv2 = zeros(0,y);   % allocate size
for i = 2:y-1
    post_deriv2(1,i) = (post_ischemia(1, i+1) - (2 * post_ischemia(1, i)) + post_ischemia(1, i-1)) / h^2;   % calculate 2nd deriv
end

post_deriv1_diff = diff(post_ischemia) ./ h;    % verify derivs with diff
post_deriv1_diff(1,305) = 0;

post_deriv2_diff = diff(post_deriv1_diff) ./ h;
post_deriv2_diff(1, 305) = 0;

figure(2)
subplot(2,1,1)
plot(t, pre_deriv1);                            % plot 1st deriv as calculated with equations
hold on                                         % continue plotting on same graph
plot(t, pre_deriv1_diff);                       % plot 1st deriv as calculated with diff
hold off
title('First Derivative of Pre-Ischemia LVP');  % label plot
xlabel('time (s)')
ylabel('LVP')
legend('Equations', 'diff');
subplot(2,1,2)
plot(t, pre_deriv2);                            % plot 2nd deriv as calculated with equations
hold on                                         % continue plotting on same graph
plot(t, pre_deriv2_diff)                        % plot 2nd deriv as calculated with diff
hold off
title('Second Derivative of Pre-Ischemia LVP'); % label plot
xlabel('time (s)')
ylabel('LVP')
legend('Equations', 'diff');

% same as above, but for post-ischemic data
figure(3)
subplot(2,1,1)
plot(t, post_deriv1);
hold on
plot(t, post_deriv1_diff);
hold off
title('First Derivative of Post-Ischemia LVP');
xlabel('time (s)')
ylabel('LVP')
legend('Equations', 'diff');
subplot(2,1,2)
plot(t, post_deriv2);
hold on
plot(t, post_deriv2_diff);
hold off
title('Second Derivative of Post-Ischemia LVP');
xlabel('time (s)')
ylabel('LVP')
legend('Equations', 'diff');

%%%%%%%%%%%%%%%%%%% Exercise 2 b %%%%%%%%%%%%%%%%%%%

h = 0.02;           % set step size
time = 0: h : 2;    % create time vector
x0 = 1;             % initial value
[m,n] = size(time); % find size of time vector

x_euler(1,1) = x0;   % set initial value

% calculate DE using eulers
for i = 2:n
    x_euler(1, i) = x_euler(1, i-1) + h * (x_euler(1, i-1) + time(1, i-1)); 
end

x_runge(1, 1) = 1;  % set initial value

% calculate DE using runge
for i = 2:n
    k1 = x_runge(1, i-1) + time(1, i-1);
    k2 = x_runge(1, i-1) + ((h * k1)/2) + time(1, i-1) + h / 2;
    k3 = x_runge(1, i-1) + ((h * k2)/2) + time(1, i-1) + h / 2;
    k4 = x_runge(1, i-1) + h*k3 + time(1, i-1) + h;
    
    x_runge(1,i) = x_runge(1, i-1) + (h / 6) * (k1 + k2 + k3 + k4);
end

% calculate DE using ode23
[t, x_23] = ode23(@(t,y) y+t, time, x0);

% create signal for analytically determined solution
for i = 1:n
    x_analytic(1,i) = 2*exp(time(1,i)) - time(1,i)-1;
end
    
figure(5)
plot(time, x_euler)     % plot euler solution
hold on                 % keep plotting on same graph
plot(time, x_runge)     % plot runge solution
plot(t, x_23)           % plot ode23 solution
plot(t, x_analytic)     % plot analytic solution
hold off
legend('Euler-Cauchy', 'Runge-Kutta', 'ode23', 'Analytic');         % label plot
title({'Results of different methods', 'to solve dx/dt = x + t'});
xlabel('time (s)');
ylabel('Amplitude');


