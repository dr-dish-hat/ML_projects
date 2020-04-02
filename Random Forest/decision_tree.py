from util import entropy, information_gain, partition_classes
import numpy as np 
import ast

class DecisionTree(object):
    def __init__(self):
        # Initializing the tree as an empty dictionary or list, as preferred
        #self.tree = []
        #self.tree = {}
        
        self.tree = {}
        self.max_depth = 20
        
        #pass

    def splitting(self, X, y):
        split_val = X[0][0]
        split_col = 0
        max_information_gain = 0

        for column in range(0, len(X[0])):

            column_val = np.median([row[column] for row in X])

            y_left, y_right = partition_classes(X, y, column, column_val)[2:4]

            curr_information_gain = information_gain(y, [y_left, y_right])

            if curr_information_gain > max_information_gain:
                max_information_gain = curr_information_gain
                split_col, split_val = column, column_val

            return split_col, split_val

    def highest_y_frequency(self, y):

        val, count = np.unique(y, return_counts = True)
        maximum_index = np.argmax(count)

        return val[maximum_index]

    def single_class_y(self, y):

        return True if len(np.unique(y)) == 1 else False

    
    def build_tree(self, X, y, depth):

        if depth >= self.max_depth:
            return self.highest_y_frequency(y)

        if self.single_class_y(y):

            return y[0]

        split_col, split_val = self.splitting(X, y)
        X_left, X_right, y_left, y_right = partition_classes(X, y, split_col, split_val)

        if len(X_left) == 0 or len(X_right) == 0:
            return self.highest_y_frequency(y)

        else:
            tree_dict = {}
            tree_dict[split_col] = [split_val, self.build_tree(X_left, y_left, depth + 1), self.build_tree(X_right, y_right, depth + 1)]

            return tree_dict

    def learn(self, X, y):
        # TODO: Train the decision tree (self.tree) using the the sample X and labels y
        # You will have to make use of the functions in utils.py to train the tree
        
        # One possible way of implementing the tree:
        #    Each node in self.tree could be in the form of a dictionary:
        #       https://docs.python.org/2/library/stdtypes.html#mapping-types-dict
        #    For example, a non-leaf node with two children can have a 'left' key and  a 
        #    'right' key. You can add more keys which might help in classification
        #    (eg. split attribute and split value)
        
        if len(y) == 0:
            self.tree['valid'] = 'no'

        self.tree = self.build_tree(X, y, 1)


        #pass




    def classify(self, record):
        # TODO: classify the record using self.tree and return the predicted label
        #pass
        predicted_label = self.tree
        while isinstance(predicted_label, dict):

            split_col = list(predicted_label.keys())[0]
            split_val = predicted_label[split_col][0]

            if type(split_val) == str:

                if record[split_col] == split_val:
                    predicted_label  = predicted_label[split_col][1]
                else:
                    predicted_label = predicted_label[split_col][2]

            else:

                if record[split_col] <= split_val:
                    predicted_label = predicted_label[split_col][1]
                else:
                    predicted_label = predicted_label[split_col][2]

        return predicted_label

