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
