function [Initial_matrix,RMSE] = Initial(similarity,train_rating,rate, test_rating, avg)
%This functinon is used to get the first generation based on the mutation of the initial similarity matrix.
%Input: similarity is the initial simialrity matrix calculated by person-based method,
%		train_rating is the training set,
%		rate is the mutation rate,
% 		test_rating is the training_test set,
%		avg is the average rating of each person.
%Output:Initial_matrix is the first simialrity generation we get,
%		RMSE is the RMSE of each simialrity matrix.
[num_user,~] = size(similarity);
num_matrix = 20;
Initial_matrix = zeros(num_matrix,num_user,num_user);
Initial_matrix(1,:,:) = similarity;
rating_by_sim = Prediction(similarity,train_rating, test_rating, avg);
Initial_RMSE = Clu_RMSE(rating_by_sim,test_rating)
RMSE = zeros(num_matrix,1);
RMSE(1,1) = Initial_RMSE;
Lower_Bound = 0.05;
for i = 2:num_matrix
    flag = 1;
    while flag == 1
    Initial_matrix(i,:,:) = Mutation1(rate,similarity);
    rating_by_sim = Prediction(Initial_matrix(i,:,:), train_rating,test_rating, avg);
    new_RMSE = Clu_RMSE(rating_by_sim,test_rating);
    if new_RMSE < Initial_RMSE + Lower_Bound %we set the lower_Bound to control the mutation so the genetic algorithm can converage faster.
        flag = 0;
        RMSE(i,1) = new_RMSE;
    end
    end
end


end

