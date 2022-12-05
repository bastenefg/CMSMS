clear all
close all
clc

%% Domain setup

xlim = 1;
ylim = 1;
Nx = 100;
Ny = 100;
x = linspace(-1,1,Nx);
y = linspace(-0.5,0.5,Ny);
dx = x(2)-x(1);
maxSpin =4;
dom = unidrnd(maxSpin, [Ny, Nx]);

Q = 1;
f_f = 1;
f_r = 1;

laserWidth = Nx;
laser = logical([ones(Ny, laserWidth), zeros(Ny, Nx-laserWidth)]);

lineDom = reshape(dom', [1,Nx*Ny]);
lineLaser = reshape(laser', [1,Nx*Ny]);

Niter = 7500;
Qb = 0.5;
nu = 1e9;
kb = 1.38e-23;
T = 1600;
fac = 1.602e-19; %1eV
iterCount = 1;
Etot = zeros(1,(Nx-laserWidth+1)*Niter);
meanArea = [];

%% Kinetic part
for laserPos = 1:Nx-laserWidth+1
    for i = 1:Niter
        trialDomain = check_possible_changes(lineDom, maxSpin, lineLaser, Nx);
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
        if mod(iterCount, 1000) == 0
            [ratio, meanA, stdA, meanATot] = process_data(reshape(lineDom, [Nx, Ny])');
            meanArea = [meanArea, meanATot];
        end
    end
    laser = circshift(laser, 1,2);
    lineLaser = reshape(laser', [1,Nx*Ny]);
end

tosend = reshape(lineDom, [Nx, Ny])';
plotDom




