function [ similarity] = Pearson(ratings, u, v, avgU, avgV)
% this function will calculate the Pearson similarity between users u and v

indexU = ratings(:, 1) == u;
indexV = ratings(:, 1) == v;
[~, iU, iV] = intersect(ratings(indexU, 2), ratings(indexV, 2)); % the co-rated items of users u and v
[row, col] = size(iU);
num = row * col;
if(num == 0)
    similarity = 0;
else
    Denominator = sqrt(sum((ratings(iU, 3) - avgU).^2) * sum((ratings(iV, 3) - avgV).^2));
    if(Denominator == 0)
        similarity = 0;
    else
    similarity = sum((ratings(iU, 3) - avgU) .* (ratings(iV, 3) - avgV)) / Denominator;
    end
end

end
