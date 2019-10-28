%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title: LE 5
% Filename: Tipton_EGR534_LE5.m 
% Author: Natalie Tipton
% Class: EGR 534
% Date: 10/8/19
% Instructor: Dr. Rhodes
% Description: This script solves the hodgkin-huxley models using
%   MATLABs ode45 and the runge-kutta method. Vm(t), n(t), m(t), h(t),
%   g_Na(t), and g_K(t) are plotted.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% runge-kutta method for series of DEs

V = 0;      % voltage for constant calculations
I = 15;      % Current showing propagation or not

g_nabar = 120;  % given constants
g_kbar = 18;
g_lbar = 0.3;
c_m = 1;
v_na = 115;
v_k = -12;
v_l = 10.6;

%calculated rate constants
a_n = (0.01 * (10 - V)) / (exp((10 - V) / 10) - 1);     
b_n = 0.125 * exp(-V / 80);
a_m = (0.1 * (25 - V)) / (exp((25 - V) / 10) - 1);
b_m = 4 * exp(-V / 18);
a_h = 0.07 * exp(-V / 20);
b_h = 1 / (exp((30 - V) / 10) + 1);

step = 0.05;                % step of time vector
t = 0 : step : 50;          % time from 0 to 50 ms at step size
N = length(t);              % find length of time vector

n(1) = a_n / (a_n + b_n);      % initial conditions
m(1) = a_m / (a_m + b_m);
h(1) = a_h / (a_h + b_h);
V(1) = 15;

%complete runge-kutta equations
for i = 2:N      
    
    % k1 = f(x_n, t_n)
    k1 = (I - g_nabar * m(i-1)^3 * h(i-1) * (V(i-1) - v_na)...
        - g_kbar * n(i-1)^4 * (V(i-1) - v_k)...
        - g_lbar * (V(i-1) - v_l)) / c_m;
    l1 = a_n * (1 - n(i-1)) - b_n * n(i-1);
    p1 = a_m  * (1 - m(i-1)) - b_m * m(i-1);
    q1 = a_h * (1 - h(i-1)) - b_h * h(i-1);
    
    % k2 = f(x_n + hk1/2, t_n + h/2)
    k2 = (I - g_nabar * (m(i-1)+(step*p1/2))^3 * (h(i-1)+(step*q1/2)) * ((V(i-1)+(step*k1/2)) - v_na)...
        - g_kbar * (n(i-1)+(step*l1/2))^4 * ((V(i-1)+(step*k1/2)) - v_k)...
        - g_lbar * ((V(i-1)+(step*k1/2)) - v_l)) / c_m;
    l2 = a_n * (1 - (n(i-1)+(step*l1/2))) - b_n * (n(i-1)+(step*l1/2));
    p2 = a_m  * (1 - (m(i-1)+(step*p1/2))) - b_m * (m(i-1)+(step*p1/2));
    q2 = a_h * (1 - (h(i-1)+(step*q1/2))) - b_h * (h(i-1)+(step*q1/2));
    
    % k3 = f(x_n + hk2/2, t_n + h/2)
    k3 = (I - g_nabar * (m(i-1)+(step*p2/2))^3 * (h(i-1)+(step*q2/2)) * ((V(i-1)+(step*k2/2)) - v_na)...
        - g_kbar * (n(i-1)+(step*l2/2))^4 * ((V(i-1)+(step*k2/2)) - v_k)...
        - g_lbar * ((V(i-1)+(step*k2/2)) - v_l)) / c_m;
    l3 = a_n * (1 - (n(i-1)+(step*l2/2))) - b_n * (n(i-1)+(step*l2/2));
    p3 = a_m  * (1 - (m(i-1)+(step*p2/2))) - b_m * (m(i-1)+(step*p2/2));
    q3 = a_h * (1 - (h(i-1)+(step*q2/2))) - b_h * (h(i-1)+(step*q2/2)); 
    
    % k4 = f(x_n + hk3, t_n + h)
    k4 = (I - g_nabar * (m(i-1)+(step*p3))^3 * (h(i-1)+(step*q3)) * ((V(i-1)+(step*k3)) - v_na)...
        - g_kbar * (n(i-1)+(step*l3))^4 * ((V(i-1)+(step*k3)) - v_k)...
        - g_lbar * ((V(i-1)+(step*k3)) - v_l)) / c_m;
    l4 = a_n * (1 - (n(i-1)+(step*l3))) - b_n * (n(i-1)+(step*l3));
    p4 = a_m  * (1 - (m(i-1)+(step*p3))) - b_m * (m(i-1)+(step*p3));
    q4 = a_h * (1 - (h(i-1)+(step*q3))) - b_h * (h(i-1)+(step*q3)); 
    
    % x_(n+1) = x_n + h/6(k1 + 2k2 + 2k3 + k4)
    V(i) = V(i-1) + (step / 6) * (k1 + 2*k2 + 2*k3 + k4);
    n(i) = n(i-1) + (step / 6) * (l1 + 2*l2 + 2*l3 + l4);
    m(i) = m(i-1) + (step / 6) * (p1 + 2*p2 + 2*p3 + p4);
    h(i) = h(i-1) + (step / 6) * (q1 + 2*q2 + 2*q3 + q4);
    
    % calculated rate constants change with each new value of V
    a_n = (0.01 * (10 - V(i))) / (exp((10 - V(i)) / 10) - 1);     
    b_n = 0.125 * exp(-V(i) / 80);
    a_m = (0.1 * (25 - V(i))) / (exp((25 - V(i)) / 10) - 1);
    b_m = 4 * exp(-V(i) / 18);
    a_h = 0.07 * exp(-V(i) / 20);
    b_h = 1 / (exp((30 - V(i)) / 10) + 1);
end

Vm = V - 80;    % V = Vm - Vrest

g_na = (m .^ 3) .* h .* g_nabar;    % solve for g_na
g_k = (n .^ 4) * g_kbar;            % solve for g_k

figure('Name', 'V_0 = 15 mv, I = 15 mA, Max Na conductance = 120, Max K conductance = 18')   %plot and label all time dependent variables
subplot(3,1,1); plot(t, Vm); title('Vm'); xlabel('time (ms)'); ylabel('Vm (mv)');
subplot(3,1,2); plot(t,g_na,t,g_k); title('Conductances');
xlabel('time (ms)'); ylabel('Conductance (mS/cm^2)'); legend('g_N_a', 'g_K');
subplot(3,1,3); plot(t,n,t,m,t,h); title('Rate Constants');
xlabel('time(ms)'); ylabel('rate (1/ms)'); legend('n', 'm', 'h');

