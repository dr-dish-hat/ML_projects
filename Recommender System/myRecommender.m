function [ U, V ] = myRecommender( rateMatrix, lowRank )
    % Please type your name here:
    name = 'Siddharth Sridhar';
    disp(name); % Do not delete this line.

    % Parameters
    maxIter = 2000; % Choose your own.
    learningRate = 0.0001; % Choose your own.
    regularizer = 0.0000000000000001; % Choose your own.
    
    % Random initialization:
    [n1, n2] = size(rateMatrix);
    U = rand(n1, lowRank) / lowRank;
    V = rand(n2, lowRank) / lowRank;
    Acc = 0.001*ones(n1, n2);
    
    % Gradient Descent:
    
    % IMPLEMENT YOUR CODE HERE.
    for iter=1:maxIter      
        U_flag = U;
        V_flag = V; 
        U = U + learningRate*(2*((rateMatrix - U*V').*(rateMatrix > 0))*V - 2*regularizer*U);
        V = V + learningRate*(2*((rateMatrix - U*V').*(rateMatrix > 0))'*U - 2*regularizer*V);
        if( abs((U_flag*V_flag') - (U*V')) == Acc)
            break;
        end
    end
end
