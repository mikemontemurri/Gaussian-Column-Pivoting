


A = [0.001234, 1.0000 ; 2.001, 3.000]
b = [1.001 ; 5.001]

%solving manually rounding to sig digits
disp('Solving manually rounding to significant digits:')
s = round(A(2,1)/A(1,1), 3);
A(2,1) = A(2,1) - round(s*A(1,1), 3);
A(2,2) = A(2,2) - round(s*A(1,2),3);
b(2,1) = b(2,1)- round(s*b(1,1),3);

%backward substitution
x2 = round(b(2,1)/A(2,2),3);
x1 = round((b(1,1)-x2*A(1,2))/A(1,1),3);
x1
x2

disp('Solving using Gauss Column Pivoting Function:')
%Using Pivoting function:
GaussColumnPivoting(A,b)