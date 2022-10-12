clear all
close all
clc

%% Domain setup

xlim = 1;
ylim = 1;
Nx = 1000;
Ny = 100;
x = linspace(0,1,Nx);
dx = x(2)-x(1);
y = linspace(0,1,Ny);
spinMax = 4;
dom = unidrnd(spinMax, [Ny, Nx]);
% plotDom

laserWidth = 3;
laser = logical([zeros(20,Nx) ; ones(Ny-40, laserWidth), zeros(Ny-40, Nx-laserWidth); zeros(20,Nx)]);

% laser = logical([zeros(10,Nx);ones(Ny-20,laserWidth), zeros(Ny-20,Nx-laserWidth);zeros(10,Nx)]);
% R = 20*dx;
% xCenter = R;
% yCenter = 0.5;
%
% laser = zeros(Nx,Ny);
%
% for i = 1:Ny
%     for j = 1:Nx
%         if sqrt((x(i)-xCenter)^2+(y(j)-yCenter)^2) < R
%             laser(j,i) = 1;
%         end
%     end
% end

lineDom = reshape(dom', [1,Nx*Ny]);
lineLaser = reshape(laser', [1,Nx*Ny]);

for iter=1:Nx-laserWidth

    for subIter = 1:50
        currEnergy = computeEnergy(lineDom, lineLaser, Nx);
%         Esave(subIter) = currEnergy;
        laserCount = 0;
        lineLaserTemp = lineLaser;

        while laserCount < sum(laser, 'all') %iterate over the whole laser domain

            randPoint = unidrnd(sum(laser, 'all')-laserCount); %pick a grid point to update
            currIdx = find(lineLaserTemp, randPoint);
            currIdx = currIdx(end);
            [trialDomVal, change] = trialEvolve(lineDom, currIdx, Nx);
            if change %do something only if something changes
                evolveDecision = evolveCheck(lineDom, trialDomVal, lineLaser, Nx, currEnergy, currIdx); %returns 0 or 1
                lineDom(currIdx) = (1-evolveDecision)*lineDom(currIdx) + trialDomVal*evolveDecision;
            end
            lineLaserTemp(currIdx) = 0;
            laserCount = laserCount + 1;
        end
    end
    laser = circshift(laser, 1, 2);
    lineLaser = reshape(laser', [1,Nx*Ny]);
    disp(100*iter/(Nx-laserWidth))

end

plotDom

