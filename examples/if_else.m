% if else statement

% fprintf(string)
% fprintf('my name is Abdelrahman')
% fprintf('%d', x)
% %d -> integer, %f -> float or double

%comparison 
% == is equal
% ~= not equal
% >= greater than or equal
% <= less than or equal
% >  greater than
% <  less than

% x = 5
% if x is equal to 5 -> print is equal.
% if x is not equal to 5 -> print not equal.

x = 10;

if (x == 5)
  fprintf('Is equal\n')
else                    % executes if the if statement fails
  fprintf('Not equal\n')
end

% \n is an escape sequence that means make a new line after printing

% if x is equal to 5, print is equal
% if x is less than 5, print x is less than 5 by #difference
% if x is greater than 5, print x is greater thant 5 by #difference

if (x == 5)
  fprintf('is equal')
elseif (x < 5)
  fprintf('x is less than 5 by %d\n', 5 - x)
elseif (x > 5)
  fprintf('x is greater than 5 by %d\n', x - 5)
end
