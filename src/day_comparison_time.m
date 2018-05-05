
%% When do the IDs with no checkin visit the park?


%% Load data
ID_duration_fri = importdata('IDs_and_durations_in_minutes_f.mat');
ID_duration_sat = importdata('ID_Duration_sat.mat');
ID_duration_sun = importdata('ID_duration_sun.mat');

ID_timestamp_fri = importdata('IDs_and_timestamps_f.mat');
ID_timestamp_sat = importdata('ID_timestamp_sat.mat');
ID_timestamp_sun = importdata('ID_timestamp_sun.mat');

unique_IDs_fri = importdata('unique_IDs_f.mat');
unique_IDs_sat = importdata('unique_ID_sat.mat');
unique_IDs_sun = importdata('unique_ID_sun.mat');

zerocheckin_friday = importdata('zerocheckin_f.mat');
zerocheckin_saturday = importdata('zerocheckin_sat.mat');
zerocheckin_sunday = importdata('zerocheckin_sun.mat');

%% Total visitors
% Answer: 11373 st

%unique_ID_total = zeros(3557+6411+7569+1, 1);
unique_ID_total(1:3557) = unique_IDs_fri;
unique_ID_total(3558:3557+6411) = unique_IDs_sat;
unique_ID_total(3558+6411+1:3558+6411+7569) = unique_IDs_sun;
unique_ID_total = unique(unique_ID_total(2:end));
%% Extract the no-checkin IDs timestamps 

%{
zerocheckin_fri_timestamp = ID_timestamp_fri(find(unique_IDs_fri == zerocheckin_friday),:);
zerocheckin_sat_timestamp1 = ID_timestamp_sat(find(unique_IDs_sat == zerocheckin_saturday(1)),:); %1st ID
zerocheckin_sat_timestamp2 = ID_timestamp_sat(find(unique_IDs_sat == zerocheckin_saturday(2)),:); %1st ID
zerocheckin_sun_timestamp = ID_timestamp_sun(find(unique_IDs_sun == zerocheckin_sunday),:);
%}

% When was the no-checkin IDs at the park? ------------
% Friday:    17:16:50 - 23:18:45    (ID = 2096715)
% Saturday1: 08:00:27 - 08:10:03    (ID = 657863)
% Saturday2: 08:45:52 - 21:34:03    (ID = 2096426)
% Sunday:    08:41:12 - 22:09:11    (ID = 2096426)

%% What IDs visited the park the entire weekend or just one day?
%  => Answer: friday_saturday_sunday_IDs (1813 st)

% What persons on friday were also in the park on saturday?
% Answer: friday_saturday_IDs

fri_sat = ismember(unique_IDs_fri, unique_IDs_sat);
c = 1;
for i = 1:length(fri_sat)
    if fri_sat(i) == 1
        friday_saturday_IDs(c) = unique_IDs_fri(i);
        c = c + 1;
    end
end

% What persons visited the park the entire weekend?
fri_sat_sun = ismember(friday_saturday_IDs, unique_IDs_sun);
c = 1;
for i = 1:length(fri_sat_sun)
    if fri_sat_sun(i) == 1
        friday_saturday_sunday_IDs(c) = friday_saturday_IDs(i);
        c = c + 1;
    end
end

%% When do those people (referred to as maniacs) visit the park? 

%maniacs_fri_timestamp = ID_timestamp_fri(find(unique_IDs_fri == friday_saturday_sunday_IDs),:);

%% Find unique IDs that visited the park > 850 minutes

c = 1;
for i = 1:length(ID_duration_fri)
    if ID_duration_fri(i,2) > 850
        IDs_over_850_minutes(c,1) = ID_duration_fri(i,1);
        IDs_over_850_minutes(c,2) = ID_duration_fri(i,2);
        c = c + 1;
    end
end
for i = 1:length(ID_duration_sat)
    if ID_duration_sat(i,2) > 850
        IDs_over_850_minutes(c,1) = ID_duration_sat(i,1);
        IDs_over_850_minutes(c,2) = ID_duration_sat(i,2);
        c = c + 1;
    end
end
for i = 1:length(ID_duration_sun)
    if ID_duration_sun(i,2) > 850
        IDs_over_850_minutes(c,1) = ID_duration_sun(i,1);
        IDs_over_850_minutes(c,2) = ID_duration_sun(i,2);
        c = c + 1;
    end
end

%% How many days does the IDs have over 850 minutes attended?
counter = 1;
IDs_over_850_minutes_sorted = sortrows(IDs_over_850_minutes); 

index = 1;
for i=1:(length(IDs_over_850_minutes_sorted) -1)
    
    if(IDs_over_850_minutes_sorted(i,1) == IDs_over_850_minutes_sorted(i+1,1))
        counter = counter + 1;   
    else
        numberOf850_perID(index, 1) = IDs_over_850_minutes_sorted(i,1);
        numberOf850_perID(index, 2) = counter;
        index = index + 1;
        counter = 1;
   end
    
end 

%IDs_over_850_minutes = unique(IDs_over_850_minutes(:,1));

%% Creating the group "park lovers"
c = 1;
for i = 1:length(numberOf850_perID)
    if numberOf850_perID(i,2) == 3
        park_lovers(c,1) = numberOf850_perID(i,1);
        park_lovers(c,2) = numberOf850_perID(i,2);
        c = c + 1;
    end
end



%% Scotty Jones Lovers

counter = 1;
for i=1:length(unique_IDs_fri)
    id = unique_IDs_fri(i,1);
    for x=1:length(parsed_data_friday)
        if(id == parsed_data_friday.id(x) && parsed_data_friday.type(x) == 'check-in')
            if( parsed_data_friday.xCoordinates(x) > (1172/4044)*100 && parsed_data_friday.xCoordinates(x) < (1470/4044)*100 && parsed_data_friday.yCoordinates(x) > (2670/4013)*100 && parsed_data_friday.yCoordinates(x) < (3250/4013)*100 )
            
            IDs_checkins_timestamps(counter,1) = id;
            IDs_checkins_timestamps(counter,2) = parsed_data_friday.timestamp(x);
            counter = counter + 1;
            end
        end
    end
end

%%IDs_movements_timestamps_32_sorted = sortrows(IDs_movements_timestamps);



