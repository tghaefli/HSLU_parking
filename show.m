clear; close all; clc

%--------------- Configuration ---------------
OCTAVE  = false;
FILTER  = false;

%1: year
%2: month
%3: day
%4: hour
%5: minute = number of data points, we log every minute
%6: second (useless)
%7: free parking slots



%----------------- Read CSV --------------------
T = readtable('stats.csv');         % read csv as table
A = table2array(T);                 % convert to matrix for cell function
%A = csvread('stats.csv');


A=A(~any(isnan(A),2),1:7);          %remove row that contans a nan

%A(:,4)=A(:,4)+1;                   %add 1 hour time offset

if not(OCTAVE)
    t = datetime(A(:,1:6));
end
free = A(:,7);


%------------------ FILTER -------------------
if FILTER
    disp('Data is FILTERered!')
    window_size = 300;
    F = ones(window_size,1)/window_size;
    %F=1                            % No FILTERer
    %F = fir1(100,1);               % 100th order FIR (finite)
    free = FILTERer(F,1,free);
end


%-------------- Console Output ----------------
str1 = ['Logged over ', sprintf('%d',numel(free)) ,' minutes (1 data point / minute)'];
str2 = ['    or over ', sprintf('%d',round(numel(free)/60)), ' hours'];
str3 = ['    or over ', sprintf('%d',round(numel(free)/60/24)), ' days' , sprintf('\n\n')];
disp(str1);
disp(str2);
disp(str3);

str1 = ['Current free slots: ', sprintf('%03d',free(end,end))];
str2 = ['Min     free slots: ', sprintf('%03d', min(free))];
str3 = ['Max     free slots: ', sprintf('%03d', max(free)) , sprintf('\n\n')];
disp(str1)
disp(str2)
disp(str3)



%------------------- Plot --------------------
hfig=figure(1);
set(hfig,'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);        % bottom left  ; width, height
if OCTAVE
    plot(free);
else
    plot(t, free);
end
title('Frei Parkplätze an der HSLU')
xlabel('Zeit')
ylabel('Freie Parkplätze')
ylim([0 max(free)])
