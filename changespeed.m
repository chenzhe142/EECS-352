
%   y2 = changespeed(y, fs, speed)
%
%   This function taks an audio signal and time-stretches (or compresses) it
%   without changing the pitch. 
%
%   Input(s):
%       y:          sampled signal vector (presumed to be an audio signal)
%
%       fs:         the sample rate of the signal. This is used to pick a
%                   a good window size for the stft at the heart of this
%                   function.
%
%       speed:      a multiplier on the tempo of the sound. 0.5 makes the 
%                   sound twice as slow. 2 makes the sound twice as
%                   fast...and so on.
%
%
%   Output(s):
%       y2:         the modified signal vector (speeded up or slowed down)
%
%   Usage:
%       load handel;
%       soundsc(y,Fs);
%       pause;
%       y2 = changespeed(y, Fs, 2); 
%       soundsc(y2,Fs);
%
% author: Zhe Chen
% email : zhechen2014@u.northwestern.edu

function y2 = changespeed(y,fs,speed)

% put your code here (hint. Doing this involves changing
% how you call istft).
len = length(y);

%define a new array to store our result
y2 = zeros;

%preserve the first point
y2(1,1) = y(1,1);

% change speed, compress or enlarge the matrix
if speed>1
    % speed up!
    for i=2:len
        %using ceil to select the neighbor point to fill the matrix
        index = ceil(i*speed);
        if index<len
            y2(i,1) = y(index,1);
        end
    end
else
    % slow down!
    for j=2:len
        index = ceil(j/speed);
        y2(index,1) = y(j,1);
        
    end
end


return;




