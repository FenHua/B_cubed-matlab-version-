function [val_pre,val_rec]=Bcubed(Clabels,Olabels)
% get the length of dataset
N=length(Clabels);
% get the number of clusters
single_o_labels=unique(Olabels);
single_p_labels=unique(Clabels);
ON=numel(single_o_labels);
CN=numel(single_p_labels);

% compute mutil B_cubed precision
P=[];
P_N=[];
for i=1:CN
    N_P=0;% count the pairs
    index=find(Clabels==single_p_labels(i));
    TN=length(index); % the length of index
    P_N=[P_N,TN];
    for j=1:TN
        for t=1:TN
            if(Olabels(index(j))==Olabels(index(t)))
                N_P=N_P+1;
            end
        end
    end
    Total_l=TN^2;
    P=[P,(min(N_P,Total_l)/Total_l)];
end
 
% compute mutil B_cubed recall
R=[];
R_N=[];
for i=1:ON
    N_R=0;% count the pairs
    index=find(Olabels==single_o_labels(i));
    TN=length(index); % the length of index
    R_N=[R_N,TN];
    for j=1:TN
        for t=1:TN
            if(Clabels(index(j))==Clabels(index(t)))
                N_R=N_R+1;
            end
        end
    end
    Total_l=TN^2;
    R=[R,((min(N_R,Total_l))/Total_l)];
end
val_pre=(P*P_N')/N;
val_rec=(R*R_N')/N;
end    
            
    

             
             
             

