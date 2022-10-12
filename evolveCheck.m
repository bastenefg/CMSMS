function evolveDecision = evolveCheck(lineDom, trialDomVal, lineLaser, Nx, currEnergy, currIdx)

lineDom(currIdx) = trialDomVal;
testEnergy = computeEnergy(lineDom, lineLaser, Nx);
% currEnergy
dE = testEnergy-currEnergy;
% randNum = rand;
% P = exp(-dE/10);
% caseNum = dE<=0;
% evolveDecision = caseNum+(1-caseNum)*(randNum<P);
evolveDecision = dE<=0;

end