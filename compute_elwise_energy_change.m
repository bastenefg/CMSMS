function [eChange] = compute_elwise_energy_change(newDom, oldDom, Nx)
%input: new domain, old domain
%computes the element-wise energy change over the whole domain

dim = size(newDom);
oldDom2 = repmat(oldDom,dim(1),1);

E1 = (newDom~=circshift(oldDom2,-Nx-1,2));
E2 = (newDom~=circshift(oldDom2,-Nx,2));
E3 = (newDom~=circshift(oldDom2,-Nx+1,2));
E4 = (newDom~=circshift(oldDom2,-1,2));
E5 = (newDom~=circshift(oldDom2,1,2));
E6 = (newDom~=circshift(oldDom2,Nx-1,2));
E7 = (newDom~=circshift(oldDom2,Nx,2));
E8 = (newDom~=circshift(oldDom2,Nx+1,2));

oldEnergy = compute_total_energy(oldDom, Nx);

eChange = E1+E2+E3+E4+E5+E6+E7+E8-oldEnergy;

end