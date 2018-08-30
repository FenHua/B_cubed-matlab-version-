function [val_pre,val_rec]=Bcubed(Clabels,Olabels)
% get the length of dataset
N=length(Clabels);

% compute the B_cubed precision and recall
P=[];
R=[];
 for i=1:N
     for j=1:N
         %compute precision
         if(Clabels(i)==Clabels(j))
             P=[P,mult_P(i,j,Clabels,Olabels)];
         end
         %compute recall
         if(Olabels(i)==Olabels(j))
             R=[R,mult_R(i,j,Clabels,Olabels)];
         end
     end
 end

val_pre=mean(P);
val_rec=mean(R);
end

function[VP]=mult_P(i,j,Clabels,Olabels)
VP=min([(Clabels(i)==Clabels(j)),(Olabels(i)==Olabels(j))]);
end
function[VR]=mult_R(i,j,Clabels,Olabels)
VR=min([(Clabels(i)==Clabels(j)),(Olabels(i)==Olabels(j))]);
end
             
             
             

