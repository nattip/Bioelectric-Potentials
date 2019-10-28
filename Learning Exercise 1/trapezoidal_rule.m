function integral = trapezoidal_rule(data)

% This function computes the sampled integral using Simpson's 1/3 rule
%
% The only input is the data table to integrate with 
%   First Column = Variable index
%   Second Column = f(x) value
%
% Written By Natalie Tipton, September 8, 2019 


h = data(2,1) - data(1,1);      % find step size of data
[m,n] = size(data);             % find size of data

integral = (h / 2) * data(1,2);     % calculate first data point of integral

for i = 2:(m-1)
    integral = integral + (h / 2) * 2 * data(i,2);  % find middle data points
end

integral = integral + (h / 2) * data(m,2);      % find final data point