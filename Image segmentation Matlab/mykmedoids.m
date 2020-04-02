function [ class, centroids ] = mykmedoids( pixels, K )

% Image segmentation using K-Medoids

m = size(pixels, 1); %rows
n = size(pixels, 2); %cols

centroids = zeros(K, n);
rand_index = randperm(m);
centroids = pixels(rand_index(1:K), :);
ids = zeros(m, 1);

iterations = 100;
cost = zeros(iterations, 1);
for iter = 1:iterations
    %Assigning clusters
    for i = 1:m
        distances = zeros(1, K);
        for j = 1:K
            distances(1,j) = sumabs(pixels(i,:) - centroids(j,:));
        end
        [dist, ids(i)] = min(distances);
        cost(iter) = cost(iter) + dist;
    end
    for i = 1:K
        xi = pixels(ids == i, :);
        a = size(xi(:,1));
        if(a == 0)
            fprintf('empty cluster');
        end
        centroids(i, :) = median(xi);
    end
    if (iter ~= 1 && cost(iter-1) == cost(iter))
         break;
    end
end
for i = 1:m
    class(i, 1) = ids(i, 1);
    centroid(i, :) = centroids(ids(i), :);
end
[class, centroid];
end

