% OBS: Varibler i detta script ber?knas i andra filer

IDs_and_coordinates_fri = importdata('Friday/checkins/IDs_and_checkin_coordinates_sorted_by_ID_f.mat');
IDs_and_coordinates_sat = importdata('Saturday/checkins/data_checkin_xy_sorted_sat.mat');
IDs_and_coordinates_sun = importdata('Sunday/checkins/IDs_and_checkin_coordinates_sorted_sun.mat');

%% Friday Checkins
clear latebirds_coordinates
clear i_fri
clear c_fri

i_fri = find(IDs_and_coordinates_fri(:,1) == late_birds_fri(1));
c_fri = IDs_and_coordinates_fri(i_fri, 2:3);
latebirds_coordinates(1:length(c_fri),:) = c_fri;

for i = 2:length(late_birds_fri)
    i_fri = find(IDs_and_coordinates_fri(:,1) == late_birds_fri(i));
    c_fri = IDs_and_coordinates_fri(i_fri, 2:3);
    
    %park_lovers_coordinates = [park_lovers_coordinates ; c_fri];
    latebirds_coordinates(end+1:end+length(c_fri), :) = c_fri;
end

maxX = max(latebirds_coordinates(:,1));
maxY = max(latebirds_coordinates(:,2));

histogram2(latebirds_coordinates(:,1), latebirds_coordinates(:,2), 30,'DisplayStyle','tile','ShowEmptyBins','on', ...
    'XBinLimits',[0 maxX],'YBinLimits',[0 maxY]);
set(gca, 'FontSize', 15)
colormap parula
h = colorbar;
ylabel(h, 'Number of Checkins')
hold on
scatter(parsed_data_saturday.xCoordinates,parsed_data_saturday.yCoordinates,15)
grid off
axis equal
xlabel('x-coordinate')
ylabel('y-coordinate')
zlabel('checkins')
title('Late Birds: Check-in Histogram (Friday)')

%% Saturday Checkins
clear latebirds_coordinates
clear i_fri
clear c_fri

i_fri = find(IDs_and_coordinates_sat(:,1) == late_birds_sat(1));
c_fri = IDs_and_coordinates_sat(i_fri, 2:3);
latebirds_coordinates(1:length(c_fri),:) = c_fri;

for i = 2:length(late_birds_sat)
    i_fri = find(IDs_and_coordinates_sat(:,1) == late_birds_sat(i));
    c_fri = IDs_and_coordinates_sat(i_fri, 2:3);
    
    %park_lovers_coordinates = [park_lovers_coordinates ; c_fri];
    latebirds_coordinates(end+1:end+length(c_fri), :) = c_fri;
end

maxX = max(latebirds_coordinates(:,1));
maxY = max(latebirds_coordinates(:,2));

histogram2(latebirds_coordinates(:,1), latebirds_coordinates(:,2), 30,'DisplayStyle','tile','ShowEmptyBins','on', ...
    'XBinLimits',[0 maxX],'YBinLimits',[0 maxY]);
set(gca, 'FontSize', 15)
colormap parula
h = colorbar;
ylabel(h, 'Number of Checkins')
hold on
scatter(parsed_data_saturday.xCoordinates,parsed_data_saturday.yCoordinates,15)
grid off
axis equal
xlabel('x-coordinate')
ylabel('y-coordinate')
zlabel('checkins')
title('Late Birds: Check-in Histogram (Saturday)')

%% Sunday Checkins
clear latebirds_coordinates
clear i_fri
clear c_fri

i_fri = find(IDs_and_coordinates_sun(:,1) == late_birds_sun(1));
c_fri = IDs_and_coordinates_sun(i_fri, 2:3);
latebirds_coordinates(1:length(c_fri),:) = c_fri;

for i = 2:length(late_birds_sun)
    i_fri = find(IDs_and_coordinates_sun(:,1) == late_birds_sun(i));
    c_fri = IDs_and_coordinates_sun(i_fri, 2:3);
    
    %park_lovers_coordinates = [park_lovers_coordinates ; c_fri];
    latebirds_coordinates(end+1:end+length(c_fri), :) = c_fri;
end

maxX = max(latebirds_coordinates(:,1));
maxY = max(latebirds_coordinates(:,2));

histogram2(latebirds_coordinates(:,1), latebirds_coordinates(:,2), 30,'DisplayStyle','tile','ShowEmptyBins','on', ...
    'XBinLimits',[0 maxX],'YBinLimits',[0 maxY]);
set(gca, 'FontSize', 15)
colormap parula
h = colorbar;
ylabel(h, 'Number of Checkins')
hold on
scatter(parsed_data_saturday.xCoordinates,parsed_data_saturday.yCoordinates,15)
grid off
axis equal
xlabel('x-coordinate')
ylabel('y-coordinate')
zlabel('checkins')
title('Late Birds: Check-in Histogram (Sunday)')

%% Activity over hours (friday)

clear latebirds_timestamps_fri
clear i_fri
clear c_fri
clear i_fri_checkins

c_fri = parsed_data_friday.timestamp(parsed_data_friday.id == late_birds_fri(1));
latebirds_timestamps_fri(1:length(c_fri),:) = c_fri;

for i = 2:length(late_birds_fri)

    c_fri = parsed_data_friday.timestamp(parsed_data_friday.id == late_birds_fri(i));
    latebirds_timestamps_fri(end+1:end+length(c_fri), :) = c_fri;
end

%% Activity over hours (saturday)

clear latebirds_timestamps_sat
clear i_fri
clear c_fri
clear i_fri_checkins

c_fri = parsed_data_saturday.timestamp(parsed_data_saturday.id == late_birds_sat(1));
latebirds_timestamps_sat(1:length(c_fri),:) = c_fri;

for i = 2:length(late_birds_sat)
    c_fri = parsed_data_saturday.timestamp(parsed_data_saturday.id == late_birds_sat(i));
    latebirds_timestamps_sat(end+1:end+length(c_fri), :) = c_fri;
end

%% Activity over hours (sunday)

clear latebirds_timestamps_sun
clear i_fri
clear c_fri
clear i_fri_checkins

c_fri = parsed_data_sunday.timestamp(parsed_data_sunday.id == late_birds_sun(1));
latebirds_timestamps_sun(1:length(c_fri),:) = c_fri;

for i = 2:length(late_birds_sun)
    c_fri = parsed_data_sunday.timestamp(parsed_data_sunday.id == late_birds_sun(i));
    latebirds_timestamps_sun(end+1:end+length(c_fri), :) = c_fri;
end


%% Plot

[N1, edges1] = histcounts(latebirds_timestamps_fri.Hour);
[N2, edges2] = histcounts(latebirds_timestamps_sat.Hour);
[N3, edges3] = histcounts(latebirds_timestamps_sun.Hour);
figure
plot(edges1(2:end), N1, edges2(2:end), N2, edges3(2:end), N3, 'LineWidth', 3)
set(gca, 'FontSize', 17);
legend('Friday', 'Saturday', 'Sunday');
title('Late Birds Activity')
xlabel('Hour', 'FontSize', 15)
ylabel('Quantity', 'FontSize', 15)