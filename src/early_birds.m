%% Friday Checkins
clear early_coordinates
clear i_fri
clear c_fri

i_fri = find(IDs_and_coordinates_fri(:,1) == early_birds_fri(1));
c_fri = IDs_and_coordinates_fri(i_fri, 2:3);
early_coordinates(1:length(c_fri),1) = c_fri(1);
early_coordinates(1:length(c_fri),2) = c_fri(2);

for i = 2:length(early_birds_fri)
    i_fri = find(IDs_and_coordinates_fri(:,1) == early_birds_fri(i));
    c_fri = IDs_and_coordinates_fri(i_fri, 2:3);
    
    %park_lovers_coordinates = [park_lovers_coordinates ; c_fri];
    early_coordinates(end+1:end+length(c_fri), :) = c_fri;
end

maxX = max(early_coordinates(:,1));
maxY = max(early_coordinates(:,2));

histogram2(early_coordinates(:,1), early_coordinates(:,2), 30,'DisplayStyle','tile','ShowEmptyBins','on', ...
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
title('Disappointed persons: Check-in Histogram (Friday)')


%% Saturday Checkins
clear early_coordinates
clear i_sat
clear c_sat

i_sat = find(IDs_and_coordinates_sat(:,1) == early_birds_sat(1));
c_sat = IDs_and_coordinates_sat(i_sat, 2:3);
early_coordinates(1:length(c_sat),:) = c_sat;

for i = 2:length(early_birds_sat)
    i_sat = find(IDs_and_coordinates_sat(:,1) == early_birds_sat(i));
    c_sat = IDs_and_coordinates_sat(i_sat, 2:3);
    
    %park_lovers_coordinates = [park_lovers_coordinates ; c_fri];
    early_coordinates(end+1:end+length(c_sat), :) = c_sat;
end

maxX = max(early_coordinates(:,1));
maxY = max(early_coordinates(:,2));

histogram2(early_coordinates(:,1), early_coordinates(:,2), 30,'DisplayStyle','tile','ShowEmptyBins','on', ...
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
title('Disappointed persons: Check-in Histogram (Saturday)')

%% Sunday Checkins
clear early_coordinates
clear i_sun
clear c_sun

i_sun = find(IDs_and_coordinates_sun(:,1) == early_birds_sun(1));
c_sun = IDs_and_coordinates_sun(i_sun, 2:3);
early_coordinates(1:length(c_sun),:) = c_sun;

for i = 2:length(early_birds_sun)
    i_sun = find(IDs_and_coordinates_sun(:,1) == early_birds_sun(i));
    c_sun = IDs_and_coordinates_sun(i_sun, 2:3);
    
    early_coordinates(end+1:end+length(c_sun), :) = c_sun;

    %park_lovers_coordinates = [park_lovers_coordinates ; c_fri];
    
end

maxX = max(early_coordinates(:,1));
maxY = max(early_coordinates(:,2));

histogram2(early_coordinates(:,1), early_coordinates(:,2), 30,'DisplayStyle','tile','ShowEmptyBins','on', ...
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
title('Disappointed persons: Check-in Histogram (Sunday)')

%% Animation of their movements

coordinates(:,1) = parsed_data_saturday.xCoordinates( parsed_data_saturday.id == early_birds_sat(1) ,:);
coordinates(:,2) = parsed_data_saturday.yCoordinates( parsed_data_saturday.id == early_birds_sat(1) ,:);

comet(coordinates(:,1), coordinates(:,2));