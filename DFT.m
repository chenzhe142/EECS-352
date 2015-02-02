%
% X = DFT(x,N)
%
%This performs a discrete Fourier transform using the exact math that I put
%in my lecture notes for EECS 352 "Machine Perception of Music"
%
% ARGUMENTS
% -------------------------------------------------------
% x = a complex signal
%
% N = the number of points in the FFT. This will make an N point window of
% the first N points in x.
%     
% RETURNS
%------------------------------------------------------------
% X = a complex frequency analysis of signal x
%
function X = DFT(x,N)
    X = zeros;
    for k = 1:N
        %clear the value of temp, begin new calculation.
        temp = 0;
        for n = 1:N
            %calculate DFT, according to the formula from class.
            temp = temp + x(n)*exp(-(1j*2*pi/N)*(k-1)*(n-1));
        end
        %temp delivers DFT frequency of each point to result X(k)
        X(k) = temp;
    end
        




