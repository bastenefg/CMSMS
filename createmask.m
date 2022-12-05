function [areas,ratio_color1] = createmask(tosend,num)

    for i=1:length(tosend)
        for j=1:length(tosend)
            if tosend(i,j)==num
            color1(i,j) = 1;
            else
            color1(i,j) = 0;
            end 
        end
      
    end 
    
    matrix=regionprops(logical(color1));

    for i=1:length(matrix)
        areas(i)=matrix(i).Area;
    end
    
    ratio_color1 = length(find(color1==1))/length(color1)^2;
end 