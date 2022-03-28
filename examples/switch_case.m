%switch case
% x
% x = 1 -> print x is equal to 1
% x = 2 -> print x is greater than 1
% x = 0 -> print x is less than 1
% otherwise print x is not found

x = 2;

switch (x)
  case 1      % if x == 1
    fprintf('x is equal to 1\n')
  case 2
    fprintf('x is greater than 1\n')
  case 0
    fprintf('x is less than 1\n')
  otherwise   % like the else in the if else statement
    fprintf('x is not found\n')
endswitch
    
% string name switch case if name is equal to abdelrahman, print hello abdelrahman
% if name is equal to ahmed, print hello ahmed
% otherwise print goodbye.
name = 'Hany';

switch (name)
  case 'Abdelrahman'
    fprintf('Hello, Abdelrahman\n')
  case 'Ahmed'
    fprintf('Hello, Ahmed\n')
  otherwise
    fprintf('goodbye\n')
endswitch
   
