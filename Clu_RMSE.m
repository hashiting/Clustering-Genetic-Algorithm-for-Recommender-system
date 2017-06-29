function [ RMSE ] = Clu_RMSE(New_rating,Old_rating)
% This function is used to calculate the RMSE between predicted ratings and test dataset.
%Input: New_rating is the ratings calculated by new similarity matrix.
%		Old_rating is the true ratings.
%Output:RMSE is the RMSE.
[row,~] = size(New_rating);
RMSE = sqrt((sum((New_rating(:,3)-Old_rating(:,3)).^2))/row);

end
