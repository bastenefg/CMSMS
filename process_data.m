function [ratioOut, areaMeanOut, areaStdOut, areaGlobalMean] = process_data(tosend)

% imagesc(tosend);
ratioOut = [];
areaMeanOut = [];
areaStdOut = [];
totalArea = [];

maxSpin = max(tosend, [], 'all');

disp('******************************************************************')

for i = 1:maxSpin
    [area, ratio] = createmask(tosend,i);
    ratioOut = [ratioOut, ratio];
    areaMeanOut = [areaMeanOut, mean(area)];
    areaStdOut = [areaStdOut, std(area)];
    totalArea = [totalArea sum(area)];
    disp(['Ratio of spin ', num2str(i), ' is ', num2str(ratio), '. Area: ', num2str(mean(area)), ' +/- ', num2str(std(area))]);
end

areaGlobalMean = sum(totalArea.*areaMeanOut)/sum(totalArea);
disp(['MEAN GRAIN AREA IS ' num2str(areaGlobalMean)])

end