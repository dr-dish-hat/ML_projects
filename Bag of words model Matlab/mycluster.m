function [ class ] = mycluster( bow, K )
% Text clustering using elementary Bag of Words model
x = bow;
k = K;
nw = length(x(1, :));
nd = length(x(:, 1));

% Initialization

% Initialising classes
idx = randi([1, k], nd, 1);

% Initializing mixing coefficients and probabilities
mix = zeros(1, k);
prob = 10*rand(k, nw); 
for j = 1:k
    mix(1, j) = sum(idx(:) == j)/nd;
    prob(j, :) = prob(j, :)./sum(prob(j, :));
end

tot_iter = 5;
for iter = 1:tot_iter
    % E-Step
    for i = 1:nd
        temp = zeros(1, k);
        for j = 1:k
            temp (1, j) = prod(prob(j, :).^x(i, :), 'all');
        end
        resp(i, :) = temp./sum(temp);
    end
    % Assignment
    temp = idx;
    [~, id] = max(resp');
    idx = id';
    if(temp == idx)
        break;
    end
    % M-Step
    mix = sum(resp)/nd;
    for i = 1:k
        denom = 0;
        for j = 1:nw
            prob(i, j) = sum(resp(:,i).*x(:, j));
            denom = denom + prob(i,j);
        end
        prob(i,:) = prob(i,:)/denom;
    end
end

class = idx;
end

