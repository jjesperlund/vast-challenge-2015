
%% OBS: The commented code is already run, the result is saved as 3 struct matrices (friday,saturday, sunday)

%{
%% Load csv file
clc;
clear;

tic
fid = fopen( 'data/sunday.csv', 'r' );
data = textscan( fid, '%q%q%q%q%q%q',  'Delimiter',','       ...
            ,   'ReturnOnError',false, 'CollectOutput',true );
fclose( fid );
toc

%% Parse the data, save in a struct
tic

parsed_data = {};
parsed_data.timestamp = datetime(data{1,1}(2:end,1),'InputFormat','yyyy-M-dd HH:mm:ss');
parsed_data.id = str2double(data{1,1}(2:end,2));
parsed_data.type = string(data{1,1}(2:end,3));
parsed_data.xCoordinates = str2double(data{1,1}(2:end,4));
parsed_data.yCoordinates = str2double(data{1,1}(2:end,5));

toc
%}

%% Load data

load('parsed_data_friday')

%% Scatter plot of x/y coordinates
sz = 2;
scatter(parsed_data.xCoordinates,parsed_data.yCoordinates,sz)

%% Histogram of the timestamps
histogram(parsed_data.timestamp.Hour)

%% Map histogram
maxX = max(parsed_data.xCoordinates);
maxY = max(parsed_data.yCoordinates);

histogram2(parsed_data.xCoordinates, parsed_data.yCoordinates, 30,'DisplayStyle','tile','ShowEmptyBins','on', ...
    'XBinLimits',[0 maxX],'YBinLimits',[0 maxY]);
colormap hot
colorbar
grid off
axis equal
xlabel('x-coordinate')
ylabel('y-coordinate')
title('Frequency of X/Y coordinates in park map')


