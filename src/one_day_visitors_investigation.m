% OBS: Variabler och matriser fr?n andra filer beh?vs l?sas in
% innan denna filen kan k?ras.

%% Friday Checkins
clear one_day_visitors_coordinates
clear i_fri
clear c_fri

i_fri = find(IDs_and_coordinates_fri(:,1) == only_friday(1));
c_fri = IDs_and_coordinates_fri(i_fri, 2:3);
one_day_visitors_coordinates(1:length(c_fri),:) = c_fri;

for i = 2:length(only_friday)
    i_fri = find(IDs_and_coordinates_fri(:,1) == only_friday(i));
    c_fri = IDs_and_coordinates_fri(i_fri, 2:3);
    
    %park_lovers_coordinates = [park_lovers_coordinates ; c_fri];
    one_day_visitors_coordinates(end+1:end+length(c_fri), :) = c_fri;
end

maxX = max(one_day_visitors_coordinates(:,1));
maxY = max(one_day_visitors_coordinates(:,2));

histogram2(one_day_visitors_coordinates(:,1), one_day_visitors_coordinates(:,2), 30,'DisplayStyle','tile','ShowEmptyBins','on', ...
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
title('One day visitors: Check-in Histogram (Friday)')


%% Saturday Checkins
clear one_day_visitors_coordinates
clear i_sat
clear c_sat

i_sat = find(IDs_and_coordinates_sat(:,1) == only_saturday(1));
c_sat = IDs_and_coordinates_sat(i_sat, 2:3);
one_day_visitors_coordinates(1:length(c_sat),:) = c_sat;

for i = 2:length(only_saturday)
    i_sat = find(IDs_and_coordinates_sat(:,1) == only_saturday(i));
    c_sat = IDs_and_coordinates_sat(i_sat, 2:3);
    
    %park_lovers_coordinates = [park_lovers_coordinates ; c_fri];
    one_day_visitors_coordinates(end+1:end+length(c_sat), :) = c_sat;
end

maxX = max(one_day_visitors_coordinates(:,1));
maxY = max(one_day_visitors_coordinates(:,2));

histogram2(one_day_visitors_coordinates(:,1), one_day_visitors_coordinates(:,2), 30,'DisplayStyle','tile','ShowEmptyBins','on', ...
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
title('One day visitors: Check-in Histogram (Saturday)')

%% Sunday Checkins
clear one_day_visitors_coordinates
clear i_sun
clear c_sun

i_sun = find(IDs_and_coordinates_sun(:,1) == only_sunday(1));
c_sun = IDs_and_coordinates_sun(i_sun, 2:3);
one_day_visitors_coordinates(1:length(c_sun),:) = c_sun;

for i = 2:length(only_sunday)
    i_sun = find(IDs_and_coordinates_sun(:,1) == only_sunday(i));
    c_sun = IDs_and_coordinates_sun(i_sun, 2:3);
    
    %park_lovers_coordinates = [park_lovers_coordinates ; c_fri];
    one_day_visitors_coordinates(end+1:end+length(c_sun), :) = c_sun;
end

maxX = max(one_day_visitors_coordinates(:,1));
maxY = max(one_day_visitors_coordinates(:,2));

histogram2(one_day_visitors_coordinates(:,1), one_day_visitors_coordinates(:,2), 30,'DisplayStyle','tile','ShowEmptyBins','on', ...
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
title('One day visitors: Check-in Histogram (Sunday)')

%% Friday park lovers checkins over time (hours)

clear park_lovers_timestamps_fri
clear i_fri
clear c_fri
clear i_fri_checkins

%i_fri_checkins = find(parsed_data_friday.id == park_lovers_checkins(1,1));
%i_fri = find(parsed_data_friday.type(i_fri_checkins) == 'check-in');
%c_fri = parsed_data_friday.timestamp(i_fri);
c_fri = parsed_data_friday.timestamp(parsed_data_friday.id == park_lovers_checkins(1,1));
park_lovers_timestamps_fri(1:length(c_fri),:) = c_fri;

for i = 2:length(park_lovers_checkins)
    %i_fri_checkins = find(parsed_data_friday.id == park_lovers_checkins(i,1));
    %i_fri = find(parsed_data_friday.type(i_fri_checkins) == 'check-in');
    %c_fri = parsed_data_friday.timestamp(i_fri);
    c_fri = parsed_data_friday.timestamp(parsed_data_friday.id == park_lovers_checkins(i,1));
    
    %park_lovers_coordinates = [park_lovers_coordinates ; c_fri];
    park_lovers_timestamps_fri(end+1:end+length(c_fri), :) = c_fri;
end

%% Saturday park lovers checkins over time (hours)

clear park_lovers_timestamps_sat
clear i_fri
clear c_fri
clear i_fri_checkins

%i_fri_checkins = find(parsed_data_sunday.id == park_lovers_checkins(1,1));
%i_fri = find(parsed_data_sunday.type(i_fri_checkins) == 'check-in');
%c_fri = parsed_data_sunday.timestamp(i_fri);
c_fri = parsed_data_saturday.timestamp(parsed_data_saturday.id == park_lovers_checkins(1,1));

park_lovers_timestamps_sat(1:length(c_fri),:) = c_fri;

for i = 2:length(park_lovers_checkins)
    %i_fri_checkins = find(parsed_data_sunday.id == park_lovers_checkins(i,1));
    %i_fri = find(parsed_data_sunday.type(i_fri_checkins) == 'check-in');
    %c_fri = parsed_data_sunday.timestamp(i_fri);
    c_fri = parsed_data_saturday.timestamp(parsed_data_saturday.id == park_lovers_checkins(i,1));
    
    %park_lovers_coordinates = [park_lovers_coordinates ; c_fri];
    park_lovers_timestamps_sat(end+1:end+length(c_fri), :) = c_fri;
end

%% Sunday park lovers checkins over time (hours)

clear park_lovers_timestamps_sun
clear i_fri
clear c_fri
clear i_fri_checkins

%i_fri_checkins = find(parsed_data_sunday.id == park_lovers_checkins(1,1));
%i_fri = find(parsed_data_sunday.type(i_fri_checkins) == 'check-in');
%c_fri = parsed_data_sunday.timestamp(i_fri);
c_fri = parsed_data_sunday.timestamp(parsed_data_sunday.id == park_lovers_checkins(1,1));

park_lovers_timestamps_sun(1:length(c_fri),:) = c_fri;

for i = 2:length(park_lovers_checkins)
    %i_fri_checkins = find(parsed_data_sunday.id == park_lovers_checkins(i,1));
    %i_fri = find(parsed_data_sunday.type(i_fri_checkins) == 'check-in');
    %c_fri = parsed_data_sunday.timestamp(i_fri);
    c_fri = parsed_data_sunday.timestamp(parsed_data_sunday.id == park_lovers_checkins(i,1));
    
    %park_lovers_coordinates = [park_lovers_coordinates ; c_fri];
    park_lovers_timestamps_sun(end+1:end+length(c_fri), :) = c_fri;
end

%% Plot park lovers checkins over time (hours)

[N1, edges1] = histcounts(park_lovers_timestamps_fri.Hour);
[N2, edges2] = histcounts(park_lovers_timestamps_sat.Hour);
[N3, edges3] = histcounts(park_lovers_timestamps_sun.Hour);
figure
plot(edges1(2:end), N1, edges2(2:end), N2, edges3(2:end), N3, 'LineWidth', 3)
set(gca, 'FontSize', 17);
legend('Friday', 'Saturday', 'Sunday');
title('Park Lovers Activity')
xlabel('Hour', 'FontSize', 15)
ylabel('Quantity', 'FontSize', 15)