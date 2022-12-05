function [trialDomVal, change] = trialEvolve(lineDom, currIdx, Nx)

trialDomVal = lineDom(currIdx);
change = 1;

S1 = circshift(lineDom,-Nx-1)*(lineDom~=circshift(lineDom,-Nx-1));
S2 = circshift(lineDom,-Nx)*(lineDom~=circshift(lineDom,-Nx));
S3 = circshift(lineDom,-1)*(lineDom~=circshift(lineDom,-1));
S4 = circshift(lineDom,1)*(lineDom~=circshift(lineDom,1));
S5 = circshift(lineDom,Nx-1)*(lineDom~=circshift(lineDom,Nx-1));
S6 = circshift(lineDom,Nx)*(lineDom~=circshift(lineDom,Nx));
S7 = circshift(lineDom,Nx+1)*(lineDom~=circshift(lineDom,Nx+1));

% randChoice = [1*(topL~=0), 2*(top~=0), 3*(topR~=0), 4*(L~=0), 5*(R~=0), 6*(bottomL~=0), 7*(bottom~=0), 8*(bottomR~=0)];
% randChoice(randChoice==0) = [];

%randchoice is now an arraw 

% if isempty(randChoice) %if point surrounded by similar points, don't do anything
%     change=0;
% else 
% 
%     randNum = unidrnd(length(randChoice));
%     randTrial  = randChoice(randNum); %choose a random but different neighbor
% 
%     trialDomVal = (randTrial==1).*topL+(randTrial==2).*top+(randTrial==3).*topR+(randTrial==4).*L+(randTrial==5).*R+...
%         (randTrial==6).*bottomL+(randTrial==7).*bottom+(randTrial==8).*bottomR;
% end

end