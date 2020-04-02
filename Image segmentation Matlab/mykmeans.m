function [ class, centroids ] = mykmeans( pixels, K )
% Image Segmentation using K-Means
m = size(pixels, 1); %rows
n = size(pixels, 2); %cols

centroids = zeros(K, n);
rand_index = randperm(m);
centroids = pixels(rand_index(1:K), :);
ids = zeros(m, 1);
iterations = 100;
for iter = 1:iterations
    %Assigning clusters
    for i = 1:m
        distances = zeros(1, K);
        for j = 1:K
            distances(1,j) = sumsqr(pixels(i,:) - centroids(j,:));
        end
        [dist, ids(i)] = min(distances);
    end
    for i = 1:K
        xi = pixels(ids == i, :);
        a = size(xi(:,1));
        if(a == 0)
            fprintf('empty cluster');
        end
        centroids(i, :) = floor(mean(xi));
    end
end
for i = 1:m
    class(i, 1) = ids(i, 1);
    centroid(i, :) = centroids(ids(i), :);
end
[class, centroid];
end

