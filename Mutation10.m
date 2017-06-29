function [ output_args ] = Mutation10( rate, similarity)
% This function aims to change the similarity matrix randomly with low probability rate
%
[~, ~,num_users] = size(similarity);
tmp1 = rand(10, num_users, num_users); % this matrix declare whether to change values
for i = 1:10
    tmp1(i,:,:) = tril(reshape(tmp1(i,:,:),num_users,num_users), -1) + tril(reshape(tmp1(i,:,:),num_users,num_users), -1)';
end
tmp1 = tmp1 <= rate;
tmp2 = rand(10, num_users, num_users) * 0.6 - 0.3; % this matrix control the amplitude of changing values
for i = 1:10
    tmp2(i,:,:) = tril(reshape(tmp2(i,:,:),num_users,num_users), -1) + tril(reshape(tmp2(i,:,:),num_users,num_users), -1)';
end
output_args = similarity + tmp1 .* tmp2; % change the values in similarity
output_args(output_args(:) > 1) = 1; % limit the bound
output_args(output_args(:) < -1) = -1;

end
