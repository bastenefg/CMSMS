function [trialDomVal, change] = trialEvolve(lineDom, currIdx, Nx)

trialDomVal = lineDom(currIdx);
change = 1;

topL = lineDom(currIdx-Nx-1)*(lineDom(currIdx)~=lineDom(currIdx-Nx-1));
top = lineDom(currIdx-Nx)*(lineDom(currIdx)~=lineDom(currIdx-Nx));
topR = lineDom(currIdx-Nx+1)*(lineDom(currIdx)~=lineDom(currIdx-Nx+1));
L = lineDom(currIdx-1)*(lineDom(currIdx)~=lineDom(currIdx-1));
R = lineDom(currIdx+1)*(lineDom(currIdx)~=lineDom(currIdx+1));
bottomL = lineDom(currIdx+Nx-1)*(lineDom(currIdx)~=lineDom(currIdx+Nx-1));
bottom = lineDom(currIdx+Nx)*(lineDom(currIdx)~=lineDom(currIdx+Nx));
bottomR = lineDom(currIdx+Nx+1)*(lineDom(currIdx)~=lineDom(currIdx+Nx+1));

randChoice = [1*(topL~=0), 2*(top~=0), 3*(topR~=0), 4*(L~=0), 5*(R~=0), 6*(bottomL~=0), 7*(bottom~=0), 8*(bottomR~=0)];
randChoice(randChoice==0) = [];

if isempty(randChoice) %if point surrounded by similar points, don't do anything
    change=0;
else 

    randNum = unidrnd(length(randChoice));
    randTrial  = randChoice(randNum); %choose a random but different neighbor

    trialDomVal = (randTrial==1).*topL+(randTrial==2).*top+(randTrial==3).*topR+(randTrial==4).*L+(randTrial==5).*R+...
        (randTrial==6).*bottomL+(randTrial==7).*bottom+(randTrial==8).*bottomR;
end

end