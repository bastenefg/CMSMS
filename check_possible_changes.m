function [trialDomain] = check_possible_changes(lineDom, maxSpin, laser, Nx)

S1 = circshift(lineDom,-Nx-1);
S2 = circshift(lineDom,-Nx);
S3 = circshift(lineDom,-Nx+1);
S4 = circshift(lineDom,-1);
S5 = circshift(lineDom,1);
S6 = circshift(lineDom,Nx-1);
S7 = circshift(lineDom,Nx);
S8 = circshift(lineDom,Nx+1);

S = [S1;S2;S3;S4;S5;S6;S7;S8];

% S(:,laser==0) = []; %do not consider cells where no change is allowed 

trialDomain = zeros(maxSpin, length(S));

for i = 1:maxSpin
    trialDomain(i,:) = i*((sum(S==i)./sum(S==i))==true);
    trialDomain(i,trialDomain(i,:)==lineDom) = 0;
end

end