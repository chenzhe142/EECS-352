%   Inverse Short-Time Fourier Transform (using ifft)
%       y = istft(X,windowSize, stepSize)
%
%   Input(s):
%       X:          A  f by t matrix, where each column contains f frequency
%                   estimates. Each column is the output of an fft performed 
%                   on a window of size win. There are t estimates, this is 
%                   the number of estimates determined by the step size.
%
%       windowSize: length of the analysis window (for good resynthesis 
%                   later use a power of 2)
%
%       stepSize:   the distance between adjacent window centers, measured 
%                   in samples. (for good resynthesis later, try making the step 
%                   size 1/2 the window length)
%
%
%   Output(s):
%       y: sampled signal vector reconstructed from X
%
%   Usage:
%       load handel;
%       soundsc(y,Fs)
%       X = stft(y,1024,512); 
%       imagesc(abs(X));
%
%       y2 = isft(X,1024,512);
%       soundsc(y2, Fs)
%
%
% author: Zhe Chen
% email : zhechen2014@u.northwestern.edu

% note: This code assumes the window function used to make the stft was a
% hanning window.


function y = istft(X,windowSize, stepSize)

% get stft matrix size from input X
input_size = size(X);
num_col = input_size(2);
num_row = input_size(1);

% define an empty output y, with original length of sound
output_len = windowSize * num_col - stepSize * (num_col-1);
y(output_len,1) = 0;

start = 1;

for col = 1:num_col
    %get a row of data from stft, then do ifft
    signal_chunk = X(:,col);
    ifft_chunk = ifft(signal_chunk);
    
    j = 1;
    for i = start: (start+windowSize-1)
        % add together
        y(i,1) = y(i,1) + ifft_chunk(j);
        j = j+1;
    end
    start = start + stepSize;
end

%%%%%%%%%%%%%%%%%
% My test code: %
%%%%%%%%%%%%%%%%%
%
% y = wavread('ulysses.wav');
% Fs = 16000;
% 
% soundsc(y,Fs)
%       
% X = stft(y,1024,512, Fs,0); 
% imagesc(abs(X));
% 
% y2 = istft(X,1024,512);
% soundsc(y2, Fs)


   