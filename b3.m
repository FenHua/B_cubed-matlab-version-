function [DATA] = b3(L,K)
N = size(L,1);
% Based on first reference
[~,~,K] = unique(K);
[~,~,L] = unique(L);

% This block ensures that the function will work on legacy MATLAB
% version where the returned values were rows instead of columns
if(isrow(K))
    K = K';
end
if(isrow(L))
    L = L';
end
X_L = repmat(L,1,max(L(:)));
X_K = repmat(K,1,max(K(:)));

% Each column j has truth membership of the ith data point in Label j
L_j = (X_L == repmat((1:max(L(:))),N,1)); 

% Each column j has truth membership of the ith data point in Cluster j
K_j = (X_K == repmat((1:max(K(:))),N,1));

% The ijth element of the partitions matrix P_ij is the number of elements 
% present in Label i and Cluster j
P_ij = double(L_j)'*double(K_j);

% The ith entry of S_i/T_i is the number of elements present in 
% label/cluster i
S_i = sum(P_ij,2);
T_i = sum(P_ij,1);

% The recall and precision for label i
R_i = sum(P_ij.*P_ij,2)./(S_i.^2);
P_i = sum(P_ij'.*P_ij',2)./(T_i.^2)';

% Two different weighting schemes for average recall.
% Equal weighting of classes
% Equal weighting of entities

%  R_N = sum(R_i)/max(L(:));
R_p = sum(S_i.*R_i)/N;

% Two different weighting schemes for average precision
% P_N = sum(P_i)/max(K(:));
P_p = sum(T_i'.*P_i)/N;

F_p = harmmean([P_p R_p]);
%    F_N = harmmean([P_N R_N]);
DATA.P = P_p;
DATA.R = R_p;
DATA.F = F_p;
end