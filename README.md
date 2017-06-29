# Clustering-Genetic-Algorithm-for-Recommender-system

Our demo is a kind of recommender system based on the Pearson similarity. It firstly partitions all the users into several clusters, 
then using the Genetic Algorithm parallel on each cluster.

### Clu_RMSE.m:
	This function is used to calculate the RMSE between predicted ratings and test dataset.

### Crossover.m:
	This function is used to generate a new similarity matrix from two existing matrix using the weighted average method,
	and RMSE is the weight

### Initial.m:
	This function is used to get the first generation based on the mutation of the initial similarity matrix.

### Mutation1.m:
	This function aims to change the similarity matrix(one matrix from Initial) randomly with low probability rate

### Mutation10.m:
	This function aims to change the similarity matrices(10 matrices from Crossover) randomly with low probability rate

### Pearson.m:
	This function will calculate the Pearson similarity between two users u and v

### Prediction.m:
	This function is used to predict the ratings in test dataset based on the ratings on train dataset.

### Recommender.m:
	This script will firstly calculate the similarity matrix of users, then divide them into several clusters
	and apply the Genetic Algorithm parallel on each cluster.
	This script will finally obtain the approximate similarity matrix.

### run_test.m:
	This script uses the similarity matrix obtained from the Recommender.m to predict the ratings on test dataset.
	It will show the both the original CF method's result and our algorithm's result.

### rating.mat:
	This file is the training dataset.

### test.mat:
	This file is the test dataset.
	
### result.mat:
	This file contains all the variables from runing the Recommender.m script, and the variables is used to run the ru_test.m script.
