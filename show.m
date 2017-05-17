clear; close; clc

% Input
% year, month, day, hour, minute, free slots
%------------------------------ Configuration ------------------------------
MATLAB  = true;
FILTER  = false;


%------------------------------ Download CSV ------------------------------
% Download the csv-file from the httpurl and save it to the current
% directory
httpurl = 'http://hslu.xeg.ch/parking/raw/stats.csv';
output  = 'stats.csv';
urlwrite(httpurl,output,'Timeout',8);


%-------------------------------- Read CSV --------------------------------
T = readtable('stats.csv');         % read csv as table
A = table2array(T);                 % convert to matrix for cell function
%A = csvread('stats.csv');          % very slow


A=A(~any(isnan(A),2),:);            %remove row that contans a nan

%A(:,4)=A(:,4)+1;                   %add 1 hour time offset

free = A(:,6);

if MATLAB
    [row, ~] = size(A);            % get number of rows
    A = [A(:,1:5) zeros(row,1) A];  % add colom for "seconds"
    t = datetime(A(:,1:6));         % calcualte the date
end

clear A T row;  


%--------------------------------- FILTER ---------------------------------
if FILTER
    disp('Data is FILTERered!')
    window_size = 300;
    F = ones(window_size,1)/window_size;
    %F=1                            % No FILTERer
    %F = fir1(100,1);               % 100th order FIR (finite)
    free = FILTERer(F,1,free);
    
    clear F window_size;
end


%----------------------------- Console Output -----------------------------
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

clear str1 str2 str3


%---------------------------------- Plot ----------------------------------
hfig=figure(1);
set(hfig,'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);        % bottom left  ; width, height
if MATLAB
    plot(t, free);
else
    plot(free);
end


title('Frei Parkplätze an der HSLU Horw')
xlabel('Zeit')
ylabel('Freie Parkplätze')
ylim([0 max(free)])

clear