%% IMAGE PROCESSING - CMSMS
% clear
% close all 
clc 

% load('dom_example.mat')
figure(1)
imagesc(tosend)

maxSpin = max(tosend, [], 'all');

for i = 1:maxSpin
    [area, ratio] = createmask(tosend,i);
    disp(['Ratio of spin ', num2str(i), ' is ', num2str(ratio)]);
    figure(i)
    histogram(area,15,'Normalization','Probability')
    title(['Grain area distribution for spin ', num2str(i)]);
end

% [area_dark_blue,ratio_dark_blue] = createmask(tosend,1);
% 
% figure(2)
% histogram(area_dark_blue,30,'Normalization','Probability')
% xlabel('Area')
% ylabel('Probability')
% title('Grain area distribution for dark blue color')
% 
% [area_light_blue,ratio_light_blue] = createmask(tosend,2);
% 
% figure(3)
% histogram(area_light_blue,30,'Normalization','Probability')
% xlabel('Area')
% ylabel('Probability')
% title('Grain area distribution for light blue color')
% 
% [area_green,ratio_green] = createmask(tosend,3);
% 
% figure(4)
% histogram(area_green,30,'Normalization','Probability')
% xlabel('Area')
% ylabel('Probability')
% title('Grain area distribution for green color')
% 
% [area_yellow,ratio_yellow] = createmask(tosend,4);
% 
% figure(5)
% histogram(area_yellow,30,'Normalization','Probability')
% xlabel('Area')
% ylabel('Probability')
% title('Grain area distribution for yellow color')

%%
% Function that for a given image (.mat) filter all colors except 1 to
% obtain a binary image. It will be repeated for each of the 4 colors. 
% The function also compute the area of each grain and the weight of the
% color.

function [aires,ratio_color1]=createmask(tosend,num)

    for i=1:length(tosend)
        for j=1:length(tosend)
            if tosend(i,j)==num
            color1(i,j) = 1;
            else
            color1(i,j) = 0;
            end 
        end
      
    end 
    
    matrix=regionprops(logical(color1));

    for i=1:length(matrix)
        aires(i)=matrix(i).Area;
    end
    
    ratio_color1 = length(find(color1==1))/length(color1)^2;
end 

%% Range RGB pour les couleurs (just in case)
% Brown = [126 3 5];
% Light_Blue = [2 213 251];
% Dark_Blue = [3 44 249];
% Red = [251 41 2];
% Yellow = [251 209 3];
% Green = [131 246 122];

