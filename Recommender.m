% This script will firstly calculate the similarity matrix of users, then divide them into several clusters
% and apply the Genetic Algorithm parallel on each cluster using multiple cores of computer.

%% Initialzation
clear;

load('ratings.mat');
load('test.mat');

rate = 0.2; % the probability of mutation

[row, ~] = size(ratings);
num_users = ratings(row, 1);
weight = zeros(num_users);
sim = zeros(num_users);
avg = getAverages(ratings);
% calculate the weight matrix
for u = 1 : num_users
	% calculate the modularity of the users u and v as the distance of them
    for v = u+1 : num_users
        [similarity] = Pearson(ratings, u, v, avg(u), avg(v));
        weight(u, v) =  1 / (similarity + 2); % transverse the similarity to distance for clustering
%        weight(u, v) = similarity;
        weight(v, u) = weight(u, v);
        sim(u, v) = similarity;
        sim(v, u) = sim(u,v);
    end
end
disp('similarity done');


%% Clustering
%L = diag(sum(weight)) - weight; %L = D - W
k = 2;	% two clusters will be generated
%[eigenVectors, ~] = eigs(L, k, 'sm');
IDX = kmeans(weight, k);	% using k-means algorithm to partition the matrix to 2 cluster
clusters = cell(1, k);
for i = 1:k
    clusters{i}.IDX = find(IDX == i);
    [clusters{i}.num_users,~] = size(clusters{i}.IDX);
    Lia = ismember(ratings(:, 1), clusters{i}.IDX);
    clusters{i}.ratings = ratings(Lia, :);
    Lia = ismember(ratings(:, 1), clusters{i}.IDX);
    clusters{i}.training_test = training_test(Lia, :);
    for j = 1:clusters{i}.num_users
        clusters{i}.ratings(clusters{i}.ratings(:, 1) == clusters{i}.IDX(j), 1) = j;
        clusters{i}.training_test(clusters{i}.training_test(:, 1) == clusters{i}.IDX(j), 1) = j;
    end
    clusters{i}.avg = avg(clusters{i}.IDX);
    [clusters{i}.sim, clusters{i}.RMSE] = Initial(sim(clusters{i}.IDX, clusters{i}.IDX), ...
        clusters{i}.ratings, rate, clusters{i}.training_test, clusters{i}.avg);
end
disp('cluster done');


%% Running genetic algorithm
num_matrix = 20;
num_generation_matrix = 10;

% using multiple core to run the Genetic Algorithm on each cluster parallel
pool = parpool(k);
parfor p = 1:k
    best = min(clusters{p}.RMSE);
    worst = max(clusters{p}.RMSE);
    disp(['Initial finish,Get the first generation,The min RMSE is: ', num2str(best)]);
    disp(['max RMSE is: ', num2str(worst)]);

    %---------------Iteration---------------------------%
    count = 1;
    while 1
        Next_generation = Crossover(clusters{p}.sim,clusters{p}.RMSE, clusters{p}.num_users);
        Next_generation = Mutation10(rate,Next_generation);
        Next_RMSE = 0;
        for i = 1:num_generation_matrix
            temp_rating=Prediction(Next_generation(i,:,:),clusters{p}.ratings, clusters{p}.ratings, clusters{p}.avg);
            Next_RMSE = Clu_RMSE(temp_rating,clusters{p}.ratings);
            if Next_RMSE <= worst
                position = find(clusters{p}.RMSE == worst);
                clusters{p}.sim(position,:,:) = Next_generation(i,:,:);
                clusters{p}.RMSE(position) = Next_RMSE;
                worst = max(clusters{p}.RMSE);
            end
        end
        best = min(clusters{p}.RMSE);
        worst = max(clusters{p}.RMSE);
        print = sprintf('In the %d Round of the Cluster: %d\n\tMin RMSE is: %f\n\tMax RMSE is: %f', count, p, best, worst);
        disp(print);
    end %end the while
end %end the parfor
delete(pool);