%[cgram, time] = chromagram(signal, fs, numberOfBins, windowSize, stepSize )
%
% Creates a chromagram from the input, returning a time-chroma
% representation that maps all energy from frequencies related by a power
% of 2 (and possibly more overtones) to the same bin.  This will also 
% display the chromagram on the screen as an image with the chroma values 
% on the vertical axis and time on the horizontal axis.
%
% INPUT PARAMETERS
% ----------------
% signal      - a vector containing the signal to be processed
%
% fs           - the sample rate of the signal (samples per second) 
%
% numberOfBins - the number of quanta for which the chromagram is 
%              calculated. If set to 12, there are only 12 chroma bins (one
%              per pitch class). Bins are assumed to be equally
%               spaced in the range 0 to 1.
%
% windowSize - the size of the window in samples. rounded up to the next 
%              power of two, so that an FFT can be used on the window. 
%
% stepSize   - the distance between window centers in samples        
%              
%
% RETURNED VALUES
% ----------------
% cgram      - a sample-chroma representation that contains a real value
%              for each step and chroma increment. Here, the value in
%              each bin is the amplitude of the chroma value
%              Thus, for a 120 bin chromagram, cgram[90,42] would give 
%              the relative amplitude at step 42.
%
% time       - the time of each column of the chromagram, measured in
%              seconds
%
%
% author: Zhe Chen
% email : zhechen2014@u.northwestern.edu

function [cgram, time] = chromagram(signal, fs, numberOfBins, windowSize, stepSize)

%% create a spectrogram to generate the data we'll build the chromogram from

% make it a magnitude spectrogram (get the amplitude with "abs()")

% don't look at frequencies outside the range we're interested in. If you
% used the matlab spectrogram function, it is already taken care of.
%       X = stft(y, windowSize, stepSize, fs, display)

%% figure out what chroma every frequency has and quantize to the nearest bin

%% make chromagram: sum energy from all frequencies with the same chroma bin 

%% make sure you know the time in seconds for each time step.

%% The remainder of this is all for display of the chromagram
% display the chromagram. Use imagesc()  to display.

% label the horizontal dimension with time values measured in seconds.


% label where each pitch class is with the letter name for the pitch class.
% This is example code that worked in my implementation. Obviously, you'll
% have different variable names, etc, but you can modify it for yours.



[x, freq, time] = spectrogram(signal,windowSize,stepSize,windowSize,fs,'yaxis');

%get the real part of x.
x = abs(x);

x_size = size(x);
num_col = x_size(2);
num_row = x_size(1);
%define a result matrix
result = zeros(numberOfBins,num_col);

%initialize
i = 2;
j = 1;
    
%put point in correct bin
while j<=num_col
    while i<=num_row
        temp = x(i,j);
        chroma = log2(freq(i)) - floor(log2(freq(i)));
        position = floor(chroma*numberOfBins) + 1;
        result(position,j) = result(position,j) + temp;
        i = i + 1;
    end
	i = 2;
	j = j + 1;
end
    
%show image
imagesc(result);
axis xy;
    
cgram = result;
    
if (numberOfBins > 11)
    referencePitch = 440;  % A440 Hz
    PCchroma = zeros(1,12); % there are 12 basic chroma classes
    % This loop took PCChroma (which has a resolution = numberofBins) and
    % quantizes each one to the nearest whole chroma.
    for p = 0:11
        myPitch = referencePitch * 2^(p/12);
        PCChroma(p+1) = log2(myPitch) - floor(log2(myPitch));
    end

    
    % This line figures out where we're going to put the tick marks
    % on the y axis, one per chroma class, and stores it in ytick.
    yTick = 1 + floor(PCChroma * numberOfBins);
    % sort them so thta they're in the right order
    [yTick, sortedIndex] = sort(yTick);
    % these are the labels we'll be putting on the graph
    yTickLabel = {'A','A#','B','C','C#','D','D#','E','F','F#','G','G#'};
    yTickLabel = yTickLabel(sortedIndex);
    % label the chroma bins with pitch class
    set(gca,'ytick',yTick);
    set(gca,'yticklabel',yTickLabel);
end
% this puts a title along the y axis
ylabel('chroma bin');









