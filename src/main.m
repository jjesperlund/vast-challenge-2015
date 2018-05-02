
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

counter = 1;
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
        counter = 1;
   end
    
end    

%% Plot number of checkins per ID

figure;
bar(numberOfCheckin_perID(:,1), numberOfCheckin_perID(:,2), 'BarWidth', 75);
max_checkins = max(numberOfCheckin_perID(:,2));
xlim([min(numberOfCheckin_perID(:,1)) max(numberOfCheckin_perID(:,1))]);
ylim([0 max_checkins]);


%% Dividing into 2 groups. Higher than 50 and lower than 10 check-ins.
counterhigh = 1;
counterlow = 1;
for i=1:index
    
    if(numberOfCheckin_perID(i,2) > 50)
        IDHighCheckin(counterhigh,1) = numberOfCheckin_perID(i,1);
        IDHighCheckin(counterhigh,2) = numberOfCheckin_perID(i,2);
        counterhigh = counterhigh + 1;
    end
    if(numberOfCheckin_perID(i,2) < 10)
        IDLowCheckin(counterlow,1) = numberOfCheckin_perID(i,1);
        IDLowCheckin(counterlow,2) = numberOfCheckin_perID(i,2);
        counterlow= counterlow + 1;       
    end
     
end



%% What Id's don't have any check-ins? 

Lia = ismember(c2,numberOfCheckin_perID(:,1));
counterzero = 1;
for i=1:length(Lia)

    if(Lia(i) == 0)
        zeroCheckin(counterzero) = c2(i);
        counterzero = counterzero + 1;
    end
    
end


%% What ID's frequently check-in in what area? Tundra Land, Kiddie Land, Wet Land, Coaster Alley


for i=1:length(c2)
    counterTundra = 0;
    counterKiddie = 0;
    counterWet = 0;
    counterCoaster = 0; 
    counterEntry = 0;
    counterCheckIn = numberOfCheckin_perID(i,2);
    id = numberOfCheckin_perID(i,1);
    c2_coaster(i,1) = id;
    c2_wet(i,1) = id;
    c2_tundra(i,1) = id;
    c2_kiddie(i,1) = id;
    c2_entry(i,1) = id;
    
    while(counterCheckIn ~= 0)
       
    if((2700/4013) * 100 < data_checkin_coordinates_sorted(i,3) || (1400*100/4013 < data_checkin_coordinates_sorted(i,3) && 3322*100/4044 < data_checkin_coordinates_sorted(i,2)))
        counterCoaster = counterCoaster + 1;
        c2_coaster(i,2) = counterCoaster;
    end
    
    
    if((2700/4013) * 100 > data_checkin_coordinates_sorted(i,3) && (1800*100/4013 < data_checkin_coordinates_sorted(i,3) && 2700*100/4044 < data_checkin_coordinates_sorted(i,2)))
        counterWet = counterWet + 1;
        c2_wet(i,2) = counterWet; 
        
    end
    
    
    if((1800/4013)*100 > data_checkin_coordinates_sorted(i,3) && (2050*100/4013 > data_checkin_coordinates_sorted(i,2)))
        counterTundra = counterTundra + 1;
        c2_tundra(i,2) = counterTundra;         
    end
    
    
    
    if((2900/4013) * 100 < data_checkin_coordinates_sorted(i,2) && (1800*100/4013 > data_checkin_coordinates_sorted(i,3)))
        counterKiddie = counterKiddie + 1;
        c2_kiddie(i,2) = counterKiddie;
    end
    
    if((1800/4013) * 100 > data_checkin_coordinates_sorted(i,3) && (2000*100/4044 < data_checkin_coordinates_sorted(i,2) && 2900*100/4044 > data_checkin_coordinates_sorted(i,2)))
        counterEntry = counterEntry + 1;
        c2_entry(i,2) = counterEntry; 
        
    end
    
        counterCheckIn = counterCheckIn - 1; 
    end

end











