function [ predicted_ratings ] = Prediction( simi, train_ratings, test_ratings, avg)
% This function is used to predict the ratings in test_ratings based on the ratings on train_ratings.
% input:similarity matrix
%		train_rating is the training set,
%		test_ratings is the training_test set,
%		avg is the average rate of each person.
% output:predicted_ratings is the rating calculated by new similarity matrix.
[num_ratings, ~] = size(test_ratings);
[num_users,~] = size(avg);
simi = reshape(simi,num_users,num_users);
predicted_ratings = test_ratings;
for i = 1:num_ratings
    user = test_ratings(i, 1);
    item = test_ratings(i, 2);
    index = train_ratings(:, 2) == item;%those comments on the same item;
    users = train_ratings(index, 1);%the users which comment on the item;
    fenmu = sum(simi(user,users));
    if fenmu ~= 0
        predicted_ratings(i,3) = avg(user) + sum(simi(user,users)' .* (train_ratings(index, 3)-avg(users))) / fenmu;%get the final rating based on the similarity.
        if(predicted_ratings(i,3) > 5)
            predicted_ratings(i,3) = 5; end
        if(predicted_ratings(i,3) < 1)
            predicted_ratings(i,3) = 1; end
    else
        predicted_ratings(i,3) = avg(user);
    end
end

end
