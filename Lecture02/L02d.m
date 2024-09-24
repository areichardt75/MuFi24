% read a csv-file 
% process data
filename = 'minescore.csv';

% import data from the csv-file
T = readtable(filename);

% extract data needed
% date is associated with date of scoreline (in seconds starting at...)
scoredate = T.date;
% score is the time needed to solve gnome-mines 
score = T.score;


% time spent since first entry of file
scoredate = abs(scoredate(1)-scoredate(1:end));
% date difference counted as days
datenap = scoredate/(24*60*60);

%%
% Process data 
% Find maximum and minimum
score_min = min(score);
idmin = find(score == score_min);
date_min.sec = scoredate(idmin);
date_min.nap = datenap(idmin);

% Calculat maximum of scores
score_max = max(score);
idmax = find(score == score_max);
date_max.sec = scoredate(idmax);
date_max.nap = datenap(idmax);

score_avg = mean(score);

%% 
% There are some really great scores (times) 
% (these are errors in "simulation")
% Ignore them -- "times" values that are more than 3x average value
limit_to_cut = 3*score_avg;
id = find(score>limit_to_cut);
score(id) = [];
scoredate(id) = [];
datenap(id) = [];

%% Plot a score distribution
% Create a figure where 
% axis#1 shows score-times 
% axis#2 shows how many times a score is reached --> histogram

% create increase sort by score
[sorted_score,ID] = sort(score);
sorted_date = scoredate(ID);
sorted_nap = datenap(ID);

% count histogram bins
[N,edges] = histcounts(sorted_score);
Nx = (edges(1:end-1)+edges(2:end))/2;

% create plots
figure; 
  subplot(211);
    plot(scoredate, score, 'k-o','LineWidth',2);
    xlabel('time [s]');
    ylabel('score [s]');
  subplot(212);
    plot(Nx, N, 'r-x');


%% Smoothed 
% Create an N-sample moving average on datas
% 
N = 10;

% ms = moving sampled
ms_score = zeros(1,length(score)-N);
ms_date = zeros(size(ms_score));
% mov_sample_score = score(1)
for id=1:length(ms_score)
  ms_score(id) = sum( score(id:id+N))/N;
  ms_date(id) = sum(scoredate(id:id+N))/N;
end

%%
% samples_to_show = 100;
Ns = 100;

figure; 
  plot(ms_date(1:Ns)/3600, ms_score(1:Ns), 'b-o','LineWidth',2);
  hold on;
  plot(scoredate(N:Ns+N)/3600, score(N:Ns+N), 'r--x')



