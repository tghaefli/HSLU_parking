clear; close; clc

% Input
% year, month, day, hour, minute, free slots
%------------------------------ Configuration ------------------------------
MATLAB  = true;
FILTER  = false;
GET_NEW = true;

%------------------------------ Download CSV ------------------------------
% Download the csv-file from the httpurl and save it to the current
% directory
if GET_NEW
    httpurl = 'http://hslu.xeg.ch/parking/raw/stats.csv';
    output  = 'stats.csv';
    urlwrite(httpurl,output,'Timeout',8);
end


%-------------------------------- Read CSV --------------------------------
T = readtable('stats.csv');         % read csv as table
A = table2array(T);                 % convert to matrix for cell function
%A = csvread('stats.csv');          % very slow


A=A(~any(isnan(A),2),:);            %remove row that contans a nan

%A(:,4)=A(:,4)+1;                   %add 1 hour time offset

free = A(:,6);

if MATLAB
    [row, ~] = size(A);             % get number of rows
    A = [A(:,1:5) zeros(row,1) A];  % add colom for "seconds"
    t = datetime(A(:,1:6),'Format','eeee, dd-MMM-y HH:mm:ss');         % calcualte the date
end

clear A T row;  


%--------------------------------- FILTER ---------------------------------
if FILTER
    disp('Data is filtered!')
    window_size = 50;
    F = ones(window_size,1)/window_size;
    %F=1                            % No FILTERer
    %F = fir1(100,1);               % 100th order FIR (finite)
    free = filter(F,1,free);
        
    free = free(window_size:end);
    if MATLAB
        t = t(window_size:end);
    end

    
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