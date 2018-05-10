
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

%% What IDs visited the park the entire weekend?
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

%% What IDs only visisted the park only on friday?
% Answer: 1744 st

c = 1;
for i = 1:length(fri_sat)
    if fri_sat(i) == 0
        friday_not_saturday_IDs(c) = unique_IDs_fri(i);
        c = c + 1;
    end
end

fri_sun = ismember(unique_IDs_fri, unique_IDs_sun);
c = 1;
for i = 1:length(fri_sun)
    if fri_sun(i) == 0
        friday_not_sunday(c) = unique_IDs_fri(i);
        c = c + 1;
    end
end

temp(1:1388) = friday_not_saturday_IDs;
temp(1389:1388+1744) = friday_not_sunday;
only_friday = unique(temp);

%% What IDs only visisted the park only on saturday?
% Answer: 4598 st

sat_fri = ismember(unique_IDs_sat, unique_IDs_fri);

c = 1;
for i = 1:length(sat_fri)
    if sat_fri(i) == 0
        saturday_not_friday_IDs(c) = unique_IDs_sat(i);
        c = c + 1;
    end
end

sat_sun = ismember(unique_IDs_sat, unique_IDs_sun);
c = 1;
for i = 1:length(sat_sun)
    if sat_sun(i) == 0
        saturday_not_sunday_IDs(c) = unique_IDs_sat(i);
        c = c + 1;
    end
end

temp(1:4242) = saturday_not_friday_IDs;
temp(4243:4242+2417) = saturday_not_sunday_IDs;
only_saturday = unique(temp);

%% What IDs only visisted the park only on sunday?
% Answer: 5756 st

sun_fri = ismember(unique_IDs_sun, unique_IDs_fri);

c = 1;
for i = 1:length(sun_fri)
    if sun_fri(i) == 0
        sunday_not_friday_IDs(c) = unique_IDs_sun(i);
        c = c + 1;
    end
end

sun_sat = ismember(unique_IDs_sun, unique_IDs_sat);
c = 1;
for i = 1:length(sun_sat)
    if sun_sat(i) == 0
        sunday_not_saturday_IDs(c) = unique_IDs_sun(i);
        c = c + 1;
    end
end

temp(1:5756) = sunday_not_friday_IDs;
temp(5757:5756+3575) = sunday_not_saturday_IDs;
only_sunday = unique(temp);

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

   
    for x=1:length(parsed_data_friday.id)
        id = parsed_data_friday.id(x);
        type = parsed_data_friday.type(x);
        if(type == 'check-in')
            if( parsed_data_friday.xCoordinates(x) > (1172/4044)*100 && parsed_data_friday.xCoordinates(x) < (1470/4044)*100 && parsed_data_friday.yCoordinates(x) > (2670/4013)*100 && parsed_data_friday.yCoordinates(x) < (3250/4013)*100 )
            
            IDs_checkins_id(counter,1) = id;
            counter = counter + 1;
            end
        end
    end

IDs_checkins_sorted = sortrows(IDs_checkins_id);

%% How many check-in per "fan" ?

counter = 1;
index = 1;
for i=1:(length(IDs_checkins_sorted) -1)
    
    if(IDs_checkins_sorted(i,1) == IDs_checkins_sorted(i+1,1))
        counter = counter + 1;   
    else
        numberOfCheckin_perfanID(index, 1) = IDs_checkins_sorted(i,1);
        numberOfCheckin_perfanID(index, 2) = counter;
        index = index + 1;
        counter = 1;
   end
    
end   

numberOfCheckin_perfanID(:,2) = sortrows(numberOfCheckin_perfanID(:,2));


