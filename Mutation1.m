function [ output_args ] = Mutation1( rate, similarity )
%
[~,num_of_users] = size(similarity);
tmp1 = rand(num_of_users, num_of_users);
tmp1 = tril(tmp1, -1) + tril(tmp1, -1)';
tmp1 = tmp1 <= rate;
tmp2 = rand( num_of_users, num_of_users) * 0.6 - 0.3;
tmp2 = tril(tmp2, -1) + tril(tmp2, -1)';
output_args = similarity + tmp1 .* tmp2;
output_args(output_args(:) > 1) = 1;
output_args(output_args(:) < -1) = -1;

end
