function currEnergy = computeEnergy(lineDom, lineLaser, Nx)

topL = sum((lineDom~=circshift(lineDom, -Nx-1)).*lineLaser);
top = sum((lineDom~=circshift(lineDom, -Nx)).*lineLaser);
topR = sum((lineDom~=circshift(lineDom, -Nx+1)).*lineLaser);
L = sum((lineDom~=circshift(lineDom, -1)).*lineLaser);
R = sum((lineDom~=circshift(lineDom, 1)).*lineLaser);
bottomL = sum((lineDom~=circshift(lineDom, Nx-1)).*lineLaser);
bottom = sum((lineDom~=circshift(lineDom, Nx)).*lineLaser);
bottomR = sum((lineDom~=circshift(lineDom, Nx+1)).*lineLaser);

currEnergy = 0.5*(topL+top+topR+L+R+bottomL+bottom+bottomR);

end