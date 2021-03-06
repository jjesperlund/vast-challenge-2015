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
coordinates_satX = parsed_data_saturday.xCoordinates(indexes_sat);
coordinates_satY = parsed_data_saturday.yCoordinates(indexes_sat);

% Saturday: Extract movement data
indexes_sun = find(parsed_data_sunday.id == zerocheckin_sunday);
coordinates_sun(:,1) = parsed_data_sunday.xCoordinates(indexes_sun);
coordinates_sun(:,2) = parsed_data_sunday.yCoordinates(indexes_sun);


% Animation of the person's movement

%comet(coordinates_f(:,1), coordinates_f(:,2), 0.99)
scatter(coordinates_sun(:,1), coordinates_sun(:,2), 70, 'filled');
set(gca, 'FontSize', 16);
xlim([0 100])
ylim([0 100])
grid on
title('Park movement')
xlabel('x-coordinate')
ylabel('y-coordinate')

%% Extract the maniacs
checkins_fri = importdata('number_of_checkins_per_ID_f.mat');
checkins_sat = importdata('number_of_checkins_per_ID_sat.mat');
checkins_sun = importdata('number_of_checkins_per_ID_sun.mat');

for i=1:length(park_lovers)
    id = park_lovers(i,1);
    park_lovers_checkins(i,1) = id;
    for x=1:length(checkins_fri)
        if id == checkins_fri(x,1)
            park_lovers_checkins(i,2) = checkins_fri(x,2);
        end
        
    end
    
    for x=1:length(checkins_sat)
        if id == checkins_sat(x,1)
            park_lovers_checkins(i,2) = park_lovers_checkins(i,2) + checkins_sat(x,2);
        end
        
    end
    
    for x=1:length(checkins_sun)
        if id == checkins_sun(x,1)
            park_lovers_checkins(i,2) = park_lovers_checkins(i,2) + checkins_sun(x,2);
        end
        
    end
    
end

maniacs = park_lovers_checkins(park_lovers_checkins(:,2) > 90);

%% What do the maniacs do at the park?

% See maniacs_investigation.m


%% Kiddie Land lovers MALL

kiddie_checkins_fri = importdata('checkins_kiddie_f.mat');
kiddie_checkins_sat = importdata('checkins_kiddie_sat.mat');
kiddie_checkins_sun = importdata('checkins_kiddie_sun.mat');

kiddie_checkins_fri = kiddie_checkins_fri(find(kiddie_checkins_fri(:,2) ~= 0),:);   
kiddie_checkins_sat = kiddie_checkins_sat(find(kiddie_checkins_sat(:,2) ~= 0),:);   
kiddie_checkins_sun = kiddie_checkins_sun(find(kiddie_checkins_sun(:,2) ~= 0),:);   

kiddie_checkins_total = ones(295+565+677,2);
kiddie_checkins_total(1:295,:) = kiddie_checkins_fri; 
kiddie_checkins_total(296:295+565,:) = kiddie_checkins_sat;
kiddie_checkins_total(1+295+565:end,:) = kiddie_checkins_sun;

checkins_total = ones(3557+6411+7568,2);
checkins_total(1:3557,:) = checkins_fri; 
checkins_total(3558:3557+6411,:) = checkins_sat;
checkins_total(1+3557+6411:end,:) = checkins_sun;


% Sum the checkins if duplicates is found 
[Aunique,i,j] = unique(kiddie_checkins_total(:,1), 'rows');
Asum = accumarray(j, kiddie_checkins_total(:,2), [], @sum);
output_kiddie = [Aunique, Asum];
    
[Aunique,i,j] = unique(checkins_total(:,1), 'rows');
Asum = accumarray(j, checkins_total(:,2), [], @sum);
output_checkins = [Aunique, Asum];  

counter = 1;
for i=1:length(output_kiddie)
    for x=1:length(output_checkins)
        if output_checkins(x,1) == output_kiddie(i,1)
            ratio_kiddie(counter,1) = output_kiddie(i,1);
            ratio_kiddie(counter,2) = (output_kiddie(i,2) / output_checkins(x,2)) * 100;
            counter = counter + 1;
        end   
        
    end
    
end

families_with_small_children = ratio_kiddie( find(ratio_kiddie(:,2) == 100), : );



%% Plot families with small children group

IDs_and_coordinates_fri = importdata('Friday/checkins/IDs_and_checkin_coordinates_sorted_by_ID_f.mat');
IDs_and_coordinates_sat = importdata('Saturday/checkins/data_checkin_xy_sorted_sat.mat');
IDs_and_coordinates_sun = importdata('Sunday/checkins/IDs_and_checkin_coordinates_sorted_sun.mat');

%%

i_fri = find(IDs_and_coordinates_fri(:,1) == families_with_small_children(1));
c_fri = IDs_and_coordinates_fri(i_fri, 2:3);
coord_fri(1:length(c_fri), :) = c_fri;

i_sat = find(IDs_and_coordinates_sat(:,1) == families_with_small_children(1));
c_sat = IDs_and_coordinates_sat(i_sat, 2:3);
coord_sat(1:length(c_sat), :) = c_sat;

i_sun = find(IDs_and_coordinates_sun(:,1) == families_with_small_children(1));
c_sun = IDs_and_coordinates_sun(i_sun, 2:3);
coord_sun(1:length(c_sun), :) = c_sun;

counter_f = 0;
counter_sat = 1;
counter_sun = 0;

for i = 2:length(families_with_small_children)
    
    i_fri = find(IDs_and_coordinates_fri(:,1) == families_with_small_children(i));
    c_fri = IDs_and_coordinates_fri(i_fri, 2:3);
    
    i_sat = find(IDs_and_coordinates_sat(:,1) == families_with_small_children(i));
    c_sat = IDs_and_coordinates_sat(i_sat, 2:3);
    
    i_sun = find(IDs_and_coordinates_sun(:,1) == families_with_small_children(i));
    c_sun = IDs_and_coordinates_sun(i_sun, 2:3);    

    if(~isempty(c_fri))
        counter_f = counter_f + 1;
        coord_fri = [coord_fri; c_fri];
    end
    if(~isempty(c_sat))
        counter_sat = counter_sat + 1;
        coord_sat = [coord_sat; c_sat];
    end
    if(~isempty(c_sun))
        counter_sun = counter_sun + 1;
        coord_sun = [coord_sun; c_sun];
    end

end

coord_total(1:3065, :) = coord_fri;
coord_total(3065+1:3065+3679, :) = coord_sat;
coord_total(3065+1+3679:3065+3679+5811, :) = coord_sun;

maxX = max(coord_total(:,1));
maxY = max(coord_total(:,2));

histogram2(coord_total(:,1), coord_total(:,2), 20,'DisplayStyle','bar3','ShowEmptyBins','on', ...
    'XBinLimits',[0 maxX],'YBinLimits',[0 maxY]);
set(gca, 'FontSize', 15)
colormap hot
%colorbar
grid off
axis equal
xlabel('x-coordinate')
ylabel('y-coordinate')
zlabel('checkins')
title('Families with small children: Check-ins')

