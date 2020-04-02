function [] = homework2( )
% Recommendation System using Matrix factorization and Hyper Parameter
% Optimization
%
% Please implement your clustering algorithm in the other file, mycluster.m. Have fun coding!

load('data');
T = X(:,1:100);
label = X(:,101);

IDX = mycluster(T,4);

acc = AccMeasure(label,IDX)

% ======================== uncomment the following for extra task ========================
% n_topics = None # TODO specify num topics yourself
% load('nips')

% W = mycluster_extra(raw_count, n_topics)

% use show_topics to display your result

end