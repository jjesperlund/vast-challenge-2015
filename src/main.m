
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

%% How many unique visitors are there?

[c2,~,~] = unique(parsed_data.id,'stable');
numberUnique = length(c2);
%c2 = sort(c2);

%% Sort ID 

[sorted_IDs, id_index] = sort(parsed_data.id);
parsed_data_checkin = parsed_data.type(parsed_data.type=='check-in');

%id_str = num2str(parsed_data.id);

%id_type(:,1) = parsed_data.id;
%id_type(:,2) = id_str;
%IDs = c2;

%% Create only checkin matrix
counter = 1;
for i=1:length(sorted_IDs)

    if(parsed_data.type(i) == 'check-in')
        data_checkin_coordinates(counter,1) = parsed_data.id(i);
        data_checkin_coordinates(counter,2) = parsed_data.xCoordinates(i);
        data_checkin_coordinates(counter,3) = parsed_data.yCoordinates(i);
        counter = counter + 1;
    end
    
end

%% How many checkins do every person have?

counter = 0;
data_checkin_coordinates_sorted = sortrows(data_checkin_coordinates); 
numberOfCheckin_perID = ones(numberUnique,2);

index = 1;
for i=1:(length(data_checkin_coordinates_sorted) -1)
    
    if(data_checkin_coordinates_sorted(i,1) == data_checkin_coordinates_sorted(i+1,1))
        counter = counter + 1;   
    else
        numberOfCheckin_perID(index, 1) = data_checkin_coordinates_sorted(i,1);
        numberOfCheckin_perID(index, 2) = counter;
        index = index + 1;
        counter = 0;
   end
    
end    

%% Plot number of checkins per ID

figure;
bar(numberOfCheckin_perID(:,1), numberOfCheckin_perID(:,2), 'BarWidth', 75);
max_checkins = max(numberOfCheckin_perID(:,2));
xlim([min(numberOfCheckin_perID(:,1)) max(numberOfCheckin_perID(:,1))]);
ylim([0 max_checkins]);


