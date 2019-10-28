%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title: LE 2 Ex 0
% Filename: Tipton_LE2_ex0.m
% Author: Natalie Tipton
% Date: 9/3/19
% Instructor: Dr. Rhodes
% Description: This script performs integration on sample data and on
%   data about LVP and Calcium administration.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%% Exercise 1 a %%%%%%%%%%%%%%%%%%%

sample_data = readtable('integral.txt');        % read in data
sample_data = table2array(sample_data);         % make data useable
[m,n] = size(sample_data);                      % determine size of data

%trapezoidal rule
integral_trap = trapezoidal_rule(sample_data)   % call function for trapezoidal rule

%simpons's 1/3 rule
integral_simp = simpsons_rule(sample_data)      % call function for simpsons 1/3 rule

%%%%%%%%%%%%%%%%%%% Exercise 1 b %%%%%%%%%%%%%%%%%%%
        
LVPcalcium = readtable('LVPCalcium_Dig.txt');   % read in LVPcalcium data file
LVPcalcium = table2array(LVPcalcium);           % make file useable

figure(1)                                       
plot(LVPcalcium(:,2), LVPcalcium(:,1))          % plot pre-digoxin data
hold on
plot(LVPcalcium(:,4), LVPcalcium(:,3))          % plot post-digoxin data
hold off
title('LVP vs.Pre-Digoxin Calcium Administration')  %label plot
xlabel('Pre-Digoxin Calcium Administration')
ylabel('LVP')
legend('Pre-Digoxin', 'Post-Digoxin')           % add a legend

% use trapezoidal rule to find area in pre-digoxin loop
integral_pre_trap = trapz(LVPcalcium(:,1), LVPcalcium(:,2)) 
% verify with polyarea
integral_pre_verify = polyarea(LVPcalcium(:,1), LVPcalcium(:,2)) 

% use trapezoidal rule to find area in post-digoxin loop
integral_post_trap = trapz(LVPcalcium(:,3), LVPcalcium(:,4))
% verify with polyarea
integral_post_verify = polyarea(LVPcalcium(:,3), LVPcalcium(:,4))


