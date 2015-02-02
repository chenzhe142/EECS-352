%
% x = IDFT(X)
%
%IDFT Discrete Fourier transform. This performs the straightforward IDFT
%algortihm described in the math in my lecture notes for EECS 352 " Machine
%Perception of Music and Audio"
%
% ARGUMENTS
% -------------------------------------------------------
% X = a complex signal in the frequency domain
%
%     
% RETURNS
%------------------------------------------------------------
% x = a complex signal in the time domain
%
function x = IDFT(X)
    %get the length of input X
    N = length(X);
    
    %allocate space for output variable x
    x = zeros;
    for n = 1:N
        %clear the value of temp, begin new calculation.
        temp = 0;
        for k = 1:N
            %calculate IDFT, according to the formula from class
            temp = temp + X(k)*exp((1j*2*pi/N)*(k-1)*(n-1));
        end
        %pass value to x(n)
        x(n) = temp/N;
    end




