
%% Activity over hours (friday)

clear timestamps_fri
clear c_fri

c_fri = parsed_data_friday.timestamp(parsed_data_friday.id == zerocheckin_friday);
timestamps_fri(1:length(c_fri),:) = c_fri;

[N1, edges1] = histcounts(timestamps_fri.Hour);
figure
plot(edges1(2:end), N1, 'LineWidth', 3)
set(gca, 'FontSize', 17);
title('No check-ins: Activity (Friday)')
xlabel('Hour', 'FontSize', 15)
ylabel('Quantity', 'FontSize', 15)

%% Activity saturday
clear timestamps_sat
clear c_fri

c_fri = parsed_data_saturday.timestamp(parsed_data_saturday.id == zerocheckin_saturday(1));
timestamps_sat(1:length(c_fri),:) = c_fri;

[N1, edges1] = histcounts(timestamps_sat.Minute);
figure
plot(edges1(2:end), N1, 'LineWidth', 3)
set(gca, 'FontSize', 17);
title('No check-ins #1 : Activity in 8 am (Saturday)')
xlabel('Minutes', 'FontSize', 15)
ylabel('Quantity', 'FontSize', 15)

clear timestamps_sat
clear c_fri

c_fri = parsed_data_saturday.timestamp(parsed_data_saturday.id == zerocheckin_saturday(2));
timestamps_sat(1:length(c_fri),:) = c_fri;

[N1, edges1] = histcounts(timestamps_sat.Hour);
figure
plot(edges1(2:end), N1, 'LineWidth', 3)
set(gca, 'FontSize', 17);
title('No check-ins #2 : Activity (Saturday)')
xlabel('Hour', 'FontSize', 15)
ylabel('Quantity', 'FontSize', 15)

%% Activity over hours (sunday)

clear timestamps_sun
clear c_fri

c_fri = parsed_data_sunday.timestamp(parsed_data_sunday.id == zerocheckin_sunday);
timestamps_sun(1:length(c_fri),:) = c_fri;

[N1, edges1] = histcounts(timestamps_sun.Hour);
figure
plot(edges1(2:end), N1, 'LineWidth', 3)
set(gca, 'FontSize', 17);
title('No check-ins: Activity (Sunday)')
xlabel('Hour', 'FontSize', 15)
ylabel('Quantity', 'FontSize', 15)
