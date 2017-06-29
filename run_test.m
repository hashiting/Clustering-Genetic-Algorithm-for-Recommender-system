% This script will compare the result of Genetic algorithm with the original CF method
load('result.mat');
load('training_test.mat');

%% The original Pearson similarity result
predicted_ratings = Prediction(sim, ratings, training_test, avg);
RMSE = Clu_RMSE(predicted_ratings, training_test);
disp(['The RMSE of the original Pearson similarity is: ', num2str(RMSE)]);

%% Genetic Algorithm result
sum_RMSE = 0;
for i = 1:k
    for j = 1:20
        predicted_ratings2 = Prediction(clusters{i}.sim(j, :, :), clusters{i}.ratings, clusters{i}.test, clusters{i}.avg);
        RMSE2 = Clu_RMSE(predicted_ratings2, clusters{i}.training_test);
        sum_RMSE = sum_RMSE + RMSE2;
        disp(RMSE2);
    end
end
