%   Short-Time Fourier Transform (using fft)
%       X = stft(y, windowSize, stepSize, fs, display)
%
%   Input(s):
%       y: sampled signal vector
%
%       
%
%       windowSize: length of the analysis window (for good resynthesis 
%                   later use a power of 2...and make the window a hanning window)
%
%       stepSize:   the distance between adjacent window centers, measured 
%                   in samples. (for good resynthesis later, try picking the 
%                   right window and making the step 
%                   size 1/2 the window length)
%
%       fs:         the sample rate of the signal. This is only used if the
%                   variable "display" is set to 1. Then, the sample rate
%                   is used to figure out the frequencies of analysis and
%                   time step sizes so frequencies can be displayed in Hz
%                   and time in seconds.
%
%       display:    if set to 1, create a figure that displays it in an image 
%                   that shows the
%                   frequencies up to the Nyquist rate, where the horizontal 
%                   dimension is time and the vertical dimension is frequency. 
%                   The dimensions of the horizontal and vertical are shown 
%                   as time in seconds (horizontal) and frequency in Hz (vertical). 
%                   NOTE: Low frequencies are LOW in the display and high 
%                   frequencies are HIGH
%
%   Output(s):
%       X: A  f by t matrix, where each column contains f frequency
%       estimates. Each column is the output of an fft performed on a window 
%       over the input signal of size windowSize. There are t estimates, this 
%       is the number of estimates determined by the step size.
%
%       Therefore, X(i,j)holds a complex number giving the phase and
%       amplitude of the ith frequency at the jth analysis window. 
%
%
%   Usage:
%       load handel;
%       X = stft(y,1024,512, Fs, 1); 
%
% author: Zhe Chen
% email : zhechen2014@u.northwestern.edu

function X=stft(y,windowSize, stepSize, fs, display)



% your code goes here.

input_length = length(y);
X = zeros;
k = 0;



% for start = 1 : stepSize : (input_length - windowSize)
%     k = k + 1;
%     %may cause overflow "start+windowSize"
%     signal_chunk = y(start: start+windowSize);
%     fft_signal_chunk = fft(signal_chunk, windowSize);
%     for i = 1 : windowSize
%         X(i,k) = fft_signal_chunk(i);
%     end
% end

% size: length*1
hann_win = hann(windowSize);

index = 1;
col = 1;

while (index+windowSize <= input_length)
    %signal_chunk size format: 1*length
    signal_chunk = y(index:(index+windowSize));
    win_signal_chunk = zeros;
    
    for j = 1:windowSize
        win_signal_chunk(j) = hann_win(j) * signal_chunk(j);
    end

    fft_signal_chunk = fft(win_signal_chunk);
    for i = 1 : windowSize
        X(i,col) = fft_signal_chunk(i);
    end
    
    index = index + stepSize;
    col = col + 1;
end




% this is to call the display function
if display
    showstft(X,fs, windowSize,stepSize);
    figure(gcf); %this line makes the figure window come to the forefront
end
return;
    

    

function showstft(X, fs, windowSize, stepSize)
%showstft(X, fs, windowSize, stepsize )
%
% Takes a stft calculated using stft.m and displays it in an image that shows the
% frequencies up to the Nyquist rate, where the horizontal dimension is
% time and the vertical dimension is frequency. The dimensions of the
% horizontal and vertical are shown as time in seconds (horizontal) and
% frequency in Hz (vertical). NOTE: Low frequencies are LOW in the display
% and high frequencies are HIGH
%
% INPUT PARAMETERS
% ----------------
%       X:          A  f by t matrix, where each column contains f frequency
%                   estimates. Each column is the output of an fft performed 
%                   on a window of size windowSize. There are t estimates, this is 
%                   the number of estimates determined by the step size.
%
%       fs:         The sample rate of the original signal used to generate
%                   
%
%
%       windowSize: length of the analysis window used in building the stft
%                   X 
%
%       stepSize:   the distance between adjacent window centers, measured 
%                   in samples. (for good resynthesis later, try making the step 
%                   size 1/2 the window length)
%
%
% author: Bryan Pardo
% email : pardo@northwestern.edu

% find out how many frequencies of analysis and time steps are there by getting the size of
% the matrix containing the stft.

% now, determine the fundamental frequency of analysis from the windowSize and sample
% rate fs

% given this, we can calculate the frequencies of analysis.

% now, determine the step size between windows, using fs and stepSize

%now, find the time of the start of each window.


% Use only the portion of the stft up to the Nyquist rate
% Take the absolute value so that the imaginary part is not there
% and imagesc will display correctly
% Put the audio into a decibel scale compared to a reference value of
% 1. 


%Display the image (remember that Matlab's image function doesn't like
%complex values, so you'll have to just display the magnitudes of the audio
%not the phases.


% Now, make sure the units displayed are correct, by resetting xticklabel
% and yticklabel to the right values.
% note..."gca" means "get current axis" and returns the axis that was most
% recently drawn in or touched with a mouse-down event.

% Here, I assume freqs is a vector where freqs(k) gives the frequency in Hz 
% of the kth analysis frequency and times is a vector where times(i) is the 
% time of the ith  window, in seconds.

% ---------
% code starts here
% ---------

% find out how many frequencies of analysis and time steps are there by 
%getting the size of the matrix containing the stft.
X_size = size(X);
num_freq = X_size(1);
num_time_step = X_size(2);
col = num_time_step;

% calculate fundamental frequency, and time interval
fund_freq = fs/windowSize;
time_interval = stepSize/fs;

freq_result = X;
for i = 1:windowSize
	freq_result(i) = fund_freq * i;
end 

% get the portion of the stft up to the Nyquist rate
freq_result = freq_result(1:windowSize/2,:);

% calculate time, with time interval.
for m=1:col
    time(m) = time_interval*m;
end

% get the portion of the stft up to the Nyquist rate
X = X(1:windowSize/2,:);

% get the real part of X, then calculate with log.
X = abs(X);
X = 20*log10(X);

% draw the spectrogram.
imagesc(X);

% adjust the direction of axis
axis xy;
    
ytick = get(gca, 'ytick');
set(gca, 'yticklabel', freq_result(ytick));
set(gca,'Ydir', 'normal');
ylabel('Frequency in Hz');
    
xtick = get(gca,'xtick');
set(gca,'xticklabel', time(xtick));
xlabel('Time in Seconds');





