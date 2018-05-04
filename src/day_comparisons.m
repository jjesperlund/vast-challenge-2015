%% Load full data

parsed_data_friday = importdata('parsed_data_friday.mat');
parsed_data_saturday = importdata('parsed_data_saturday.mat');
parsed_data_sunday = importdata('parsed_data_sunday.mat');


%% Zero checkins analysis

zerocheckin_friday = importdata('zerocheckin_f.mat');
zerocheckin_saturday = importdata('zerocheckin_sat.mat');
zerocheckin_sunday = importdata('zerocheckin_sun.mat');


%% FRIDAY: Extract the movement data that belongs to the ID with no checkins

% Friday: Extract movement data
indexes_f = find(parsed_data_friday.id == zerocheckin_friday);
coordinates_f(:,1) = parsed_data_friday.xCoordinates(indexes_f);
coordinates_f(:,2) = parsed_data_friday.yCoordinates(indexes_f);

% Saturday: Extract movement data
indexes_sat = find(parsed_data_saturday.id == zerocheckin_saturday(2));
coordinates_sat(:,1) = parsed_data_saturday.xCoordinates(indexes_sat);
coordinates_sat(:,2) = parsed_data_saturday.yCoordinates(indexes_sat);

% Saturday: Extract movement data
indexes_sun = find(parsed_data_sunday.id == zerocheckin_sunday);
coordinates_sun(:,1) = parsed_data_sunday.xCoordinates(indexes_sun);
coordinates_sun(:,2) = parsed_data_sunday.yCoordinates(indexes_sun);

% Animation of the person's movement
comet(coordinates_sun(:,1), coordinates_sun(:,2), 0.8)

%% When do the IDs with no checkin visit the park?


%% Load data
ID_duration_fri = importdata('IDs_and_durations_in_minutes_f.mat');
ID_duration_sat = importdata('ID_Duration_sat.mat');
ID_duration_sun = importdata('ID_duration_sun.mat');

ID_timestamp_fri = importdata('IDs_and_timestamps_f.mat');
ID_timestamp_sat = importdata('ID_timestamp_sat.mat');
ID_timestamp_sun = importdata('ID_timestamp_sun.mat');

% Load unique IDS
unique_IDs_fri = importdata('unique_IDs_f.mat');
unique_IDs_sat = importdata('unique_ID_sat.mat');
unique_IDs_sun = importdata('unique_ID_sun.mat');

%% Extract the no-checkin IDs timestamps 

%{
zerocheckin_fri_timestamp = ID_timestamp_fri(find(unique_IDs_fri == zerocheckin_friday),:);
zerocheckin_sat_timestamp1 = ID_timestamp_sat(find(unique_IDs_sat == zerocheckin_saturday(1)),:); %1st ID
zerocheckin_sat_timestamp2 = ID_timestamp_sat(find(unique_IDs_sat == zerocheckin_saturday(2)),:); %1st ID
zerocheckin_sun_timestamp = ID_timestamp_sun(find(unique_IDs_sun == zerocheckin_sunday),:);
%}

% Result ----------------------
% Friday:    17:16:50 - 23:18:45    (ID = 2096715)
% Saturday1: 08:00:27 - 08:10:03    (ID = 657863)
% Saturday2: 08:45:52 - 21:34:03    (ID = 2096426)
% Sunday:    08:41:12 - 22:09:11    (ID = 2096426)





