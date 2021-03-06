%% MC1.2: Are there notable differences in the patterns of activity on in the park across the three days?

parsed_data_friday = importdata('parsed_data_friday.mat');
parsed_data_saturday = importdata('parsed_data_saturday.mat');
parsed_data_sunday = importdata('parsed_data_sunday.mat');

%% Plot overall movements fri, sat, sun

% Extract movements
movements_fri = parsed_data_friday.timestamp( find(parsed_data_friday.type == 'movement') );
movements_sat = parsed_data_saturday.timestamp( find(parsed_data_saturday.type == 'movement') );
movements_sun = parsed_data_sunday.timestamp( find(parsed_data_sunday.type == 'movement') );

% Extract checkins
checkins_fri = parsed_data_friday.timestamp( find(parsed_data_friday.type == 'check-in') );
checkins_sat = parsed_data_saturday.timestamp( find(parsed_data_saturday.type == 'check-in') );
checkins_sun = parsed_data_sunday.timestamp( find(parsed_data_sunday.type == 'check-in') );

% Plot movements
[N1, edges1] = histcounts(movements_fri.Hour);  
[N2, edges2] = histcounts(movements_sat.Hour);  
[N3, edges3] = histcounts(movements_sun.Hour);

figure
plot(edges1(2:end), N1, edges2(2:end), N2, edges3(2:end), N3, 'LineWidth', 3)
legend('Friday', 'Saturday', 'Sunday');
title('Movement events', 'FontSize', 16)
xlabel('Hour', 'FontSize', 15)
ylabel('Quantity', 'FontSize', 15)

% Plot checkins
[N1, edges1] = histcounts(checkins_fri.Hour);  
[N2, edges2] = histcounts(checkins_sat.Hour);  
[N3, edges3] = histcounts(checkins_sun.Hour);

figure
plot(edges1(2:end), N1, edges2(2:end), N2, edges3(2:end), N3, 'LineWidth', 3)
legend('Friday', 'Saturday', 'Sunday');
title('Check-in events', 'FontSize', 16)
xlabel('Hour', 'FontSize', 15)
ylabel('Quantity', 'FontSize', 15)

%% When did people arrive and depart on fri, sat, sun?

ID_duration_fri = importdata('IDs_and_durations_in_minutes_f.mat');
ID_duration_sat = importdata('ID_Duration_sat.mat');
ID_duration_sun = importdata('ID_duration_sun.mat');

ID_timestamp_fri = importdata('IDs_and_timestamps_f.mat');
ID_timestamp_sat = importdata('ID_timestamp_sat.mat');
ID_timestamp_sun = importdata('ID_timestamp_sun.mat');

unique_IDs_fri = importdata('unique_IDs_f.mat');
unique_IDs_sat = importdata('unique_ID_sat.mat');
unique_IDs_sun = importdata('unique_ID_sun.mat');

%% Arrivals on fri, sat, sun

[N1, edges1] = histcounts(ID_timestamp_fri(:,1).Hour);  
[N2, edges2] = histcounts(ID_timestamp_sat(:,1).Hour); 
[N3, edges3] = histcounts(ID_timestamp_sun(:,1).Hour); 

figure
plot(edges1(2:end), N1, edges2(2:end), N2, edges3(2:end), N3, 'LineWidth', 3)
set(gca, 'FontSize', 16)
legend('Friday', 'Saturday', 'Sunday');
title('Arrivals', 'FontSize', 20)
xlabel('Hour', 'FontSize', 18)
ylabel('Quantity', 'FontSize', 18)

[N1, edges1] = histcounts(ID_timestamp_fri(:,2).Hour);  
[N2, edges2] = histcounts(ID_timestamp_sat(:,2).Hour); 
[N3, edges3] = histcounts(ID_timestamp_sun(:,2).Hour); 

figure
plot(edges1(2:end), N1, edges2(2:end), N2, edges3(2:end), N3, 'LineWidth', 3)
set(gca, 'FontSize', 16)
legend('Friday', 'Saturday', 'Sunday');
title('Departures', 'FontSize', 20)
xlabel('Hour', 'FontSize', 18)
ylabel('Quantity', 'FontSize', 18)

[N1, edges1] = histcounts(ID_duration_fri(:,2));  
[N2, edges2] = histcounts(ID_duration_sat(:,2)); 
[N3, edges3] = histcounts(ID_duration_sun(:,2)); 

figure
plot(edges1(2:end), N1, edges2(2:end), N2, edges3(2:end), N3, 'LineWidth', 3)
set(gca, 'FontSize', 16)
legend('Friday', 'Saturday', 'Sunday');
title('Visit Duration', 'FontSize', 20)
xlabel('Minutes', 'FontSize', 18)
ylabel('Quantity', 'FontSize', 18)

