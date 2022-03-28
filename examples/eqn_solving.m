%We want to solve a series of linear equations
%   x +  y + 2z = 6  (1)
%  3x + 2y + 4z = 9  (2)
% -2x + 3y - 6z = 3  (3)

% We solve these series of equations using Ax = B
% where A is the matrix of coefficients of the equations
% and B is the matrix of constant terms
% this is usually solved by finding A^(-1) (the transpose of the matrix A)
% and then multiplying it by B where x = A^(-1) B
% we will see how to solve them in octave using this way.

clear;
% we start by ckearing the workspace, then write the matrix A
A = [1, 1,  2;
     3, 2,  4;
    -2, 3, -6];

B = [6; 9;  3]; %B is a column vector since there's one constant term per equation.

x = A \ B      %x is the solution we need, which is a column vector too
%x = [x ; y ; z]

% by using this way, we can solve any number of equations by the same number of variables.

% here's another example of 4 equations in 4 variables
% 2a + 2b -  c +  d = 4   (1)
% 4a + 3b -  c + 2d = 6   (2)
% 8a + 5b - 3c + 4d = 12  (3)
% 3a + 3b - 2c + 2d = 6   (4)

A = [2, 2, -1, 1;
     4, 3, -1, 2;
     8, 5, -3, 4;
     3, 3, -2, 2];
     
B = [4; 6; 12; 6];

x = A \ B
% x = [a ; b ; c ; d]
