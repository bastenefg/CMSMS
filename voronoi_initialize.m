clear all
close all
clc

Nx = 150;
Ny = 150;

nV = 300;

Xv = unidrnd(Nx, [nV,2]);
% xv = linspace(1,Nx,15);
% yv = xv;

% [Xv,Yv] = meshgrid(xv,yv);
% Xv = reshape(Xv, [15*15,1]);
% Yv = reshape(Yv, [15*15,1]);
% 
% Xv = [Xv,Yv];


while length(unique(Xv,'rows')) ~= nV
    Xv = unidrnd(Nx, [nV,2]);
end

[x,y] = meshgrid(1:Nx, 1:Ny);

Y = [reshape(x,[Nx*Ny,1]), reshape(y,[Nx*Ny,1])];

DT = delaunayTriangulation(Xv);

color = zeros(nV, 1);
numColors = 1;
vertices = 1:nV;

for k = 1:nV %iterate over all vertices
    idx = vertices(isConnected(DT,k*ones(nV,1),vertices'));
    idx = idx(idx<k);
    neighborsColor = unique(color(idx));
    newColor = min(setdiff(1:numColors, neighborsColor));
    if isempty(newColor)
        numColors = numColors + 1;
        newColor = numColors;
    end
    color(k) = newColor;
end

maxSpin = numColors;
disp([num2str(numColors), ' colors used.']);

Idx = knnsearch(Xv,Y,'distance', 'euclidean');

finalColor = color(Idx);
lineDom = finalColor';

% voronoi(Xv(:,1), Xv(:,2));
% axis equal
% xlim([1,Nx])
% ylim([1,Ny])

figure(1)
plotDom
saveas(gcf, 'BaseState.png')

%% EVOLUTION PHASE

Niter = 25000;
analyzeTime = 500;
Qb = 0.5;
nu = 1e9;
kb = 1.38e-23;
T = 1600;
fac = 1.602e-19; %1eV
iterCount = 1;
Etot = zeros(1,Niter);
meanArea = [];

for i = 1:Niter
    trialDomain = check_possible_changes(lineDom, maxSpin, ones(1,Nx*Ny), Nx);
    dV = compute_elwise_energy_change(trialDomain, lineDom, Nx);
    Q = fac*(Qb + 0.5*dV);
    Q(trialDomain==0) = Inf;
    lineQ = reshape(Q', [1,maxSpin*Nx*Ny]);
    gamma = nu*exp(-lineQ/(kb*T));
    gamma(lineQ == Inf) = 0;
    gTot = sum(gamma);
    gamma = gamma/gTot;
    idx = 1:length(gamma);
    C = cumsum(gamma);
    f = idx(1+sum(C(end)*rand>C)); %which idx of the laser region should change?
    %         lineQ(f)
    lineDom(mod(f,Nx*Ny)+Nx*Ny*(mod(f,Nx*Ny)==0)) = trialDomain(1+floor(f/(Nx*Ny))-(mod(f,(Nx*Ny))==0),mod(f,Nx*Ny)+Nx*Ny*(mod(f,Nx*Ny)==0));
    Etot(1,iterCount) = sum(compute_total_energy(lineDom, Nx),'all');
    iterCount = iterCount + 1;
    if mod(iterCount, analyzeTime) == 0
        [ratio, meanA, stdA, meanAtot] = process_data(reshape(lineDom, [Nx, Ny])');
        meanArea = [meanArea, meanAtot];
        plotDom
        saveas(gcf, ['Step_', num2str(i), '.png'])
    end
end

tosend = reshape(lineDom, [Nx, Ny])';
figure(2)
plotDom
saveas(gcf, 'FinalSate.png')

figure(3)
plot((1:length(meanArea))*analyzeTime,meanArea, 'xr', 'linewidth', 1.5)
xlabel('Iteration number', 'interpreter', 'latex')
ylabel('Mean grain area', 'interpreter', 'latex')
nice
