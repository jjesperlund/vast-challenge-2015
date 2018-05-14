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
indexes_sat = find(parsed_data_saturday.id == zerocheckin_saturday(1));
coordinates_sat(:,1) = parsed_data_saturday.xCoordinates(indexes_sat);
coordinates_sat(:,2) = parsed_data_saturday.yCoordinates(indexes_sat);

% Saturday: Extract movement data
indexes_sun = find(parsed_data_sunday.id == zerocheckin_sunday);
coordinates_sun(:,1) = parsed_data_sunday.xCoordinates(indexes_sun);
coordinates_sun(:,2) = parsed_data_sunday.yCoordinates(indexes_sun);


% Animation of the person's movement
comet(coordinates_f(:,1), coordinates_f(:,2), 0.8)
xlim([0 99])
ylim([0 99])

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

maniacs = park_lovers_checkins(park_lovers_checkins(:,2) > 50);


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



