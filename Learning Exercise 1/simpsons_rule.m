function integral = simpsons_rule(data)

%This function computes the sampled integral using Simpson's 1/3 rule
%
%The only input is the data table to integrate with 
%   First Column = Variable index
%   Second Column = f(x) value
%
% Written By Natalie Tipton, September 8, 2019 

h = data(2,1) - data(1,1);      % find step size of data
[m,n] = size(data);             % find size of data

integral = (h / 3) * data(1,2);     % find first data point of integral

for i = 2:(m-1)
    if(mod(i,2))        % if an odd i
        integral = integral + (h / 3) * 2 * data(i,2);  % calculate integral values
    else
        integral = integral + (h / 3) * 4 * data(i,2);  
    end
end

integral = integral + (h / 3) * data(m,2);      % calculate final data point
