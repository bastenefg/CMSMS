function [eTot] = compute_total_energy(newDom, Nx)
%input: line domain
%Compute the total energy of a given configuration in line format

E1 = (newDom~=circshift(newDom,-Nx-1));
E2 = (newDom~=circshift(newDom,-Nx));
E3 = (newDom~=circshift(newDom,-Nx+1));
E4 = (newDom~=circshift(newDom,-1));
E5 = (newDom~=circshift(newDom,1));
E6 = (newDom~=circshift(newDom,Nx-1));
E7 = (newDom~=circshift(newDom,Nx));
E8 = (newDom~=circshift(newDom,Nx+1));

eTot = E1+E2+E3+E4+E5+E6+E7+E8;

end