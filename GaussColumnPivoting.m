function x = GaussColumnPivoting(A,b)

%GaussColumnPivoting(A,b) solves the n-by-n linear system of equations
%using column pivoting
%A is the coeficient matrix
%b the right-hand column vector

n = size(A,1);  %getting n

%elimination process starts
for k = 1:n-1                           %checking all columns but the last because there are no entries beneath the pivot
    p(k) = k;                           %identifies current pivot position
    %comparison to select the pivot
    for i = k+1:n                       %runs through each entry in the column of matrix A            **QUESTION** why k+1:n and not k:n ??
        if abs(A(i,k)) > abs(A(p(k),k)) %check if each entry below the current k is greater than the current pivot
        p(k) = i;                       %if the entry being tested has greater magnitude, make this the new pivot point        
        end
    end

    for j = k:n                         %run through each row of the matrix
        U = A(k,j);                     %define U as the new pivot positions on the diagonal of A
        A(k,j) = A(p(k),j);             %swap the greatest magnitude entry in the column(found above) into the diagonal pivot position
        A(p(k),j) = U;                  %set this as the new matrix. Repreat through each column of the matrix
    end
    %cheking for nullity of the pivots
    while abs(A(k,k))== 0.0             %if the pivot entry is still 0 after the above process, replace it with n+1(not in the matrix)
        p(k) = n+1;                 
    end
    if p == n+1                         %if the pivot entry has been replaced by n+1, which is not in the matrix, there is not solution
        disp('No unique solution');
        break
    end
    
    for i = k+1:n                       %run through each entry in the column of the matrix starting underneath the pivot
        A(i,k) = A(i,k)/A(k,k);         %divide each entry underneath the pivot by the value of the pivot to get the scaling factor
        for j = k+1:n                   %run through each entry in the row of the matrix   
            A(i,j) = A(i,j) - A(i,k)*A(k,j); %for each row, starting from the second, subtract the value of of the scaling facotr times the pivot from each entry in the row
        end
    end
end

%checking for nonzero of last entry
if A(n,n) == 0                          %If the last entry is 0, there is no unique solution (free variable)
    disp('No unique solution');
    return
end

%process the RHS
for k = 1:n-1                           %run through each entry but the last
    U = b(k);                           %set U equal to the entry k in column vector b    
    b(k)= b(p(k));                      %set identified entry in b equal to the entry of b with index of the new pivot position of A
    b(p(k)) = U;                        %set this new entry equal to U
    %k = 1:n-1
    for i = k+1:n                       %run through each entry in the column but the first
        b(i) =b(i) - A(i,k)*b(k);       %subtract the co rresponding entry of b by the scaling factor found above time the kth entry of b
    end
end

%backward substitution
b(n) = b(n)/A(n,n);                    %each entry b(n) is equal to the entry divided by its corresponding entry in A
for k = n - 1:-1:1                     %go up each row starting from the last row
    sumax = 0;
    for j = k+1:n
        sumax = sumax + A(k,j)*b(j);   %for each entry below the pivot add the entry of A times the corresponding entry of b
    end
    b(k) = (b(k) - sumax)/A(k,k);       %the entries of b corresponding to the pivots minus the
end
x = b;
A
p

