from builtins import range
import numpy as np
from random import shuffle
from past.builtins import xrange

def softmax_loss_naive(W, X, y, reg):
    """
    Softmax loss function, naive implementation (with loops)

    Inputs have dimension D, there are C classes, and we operate on minibatches
    of N examples.

    Inputs:
    - W: A numpy array of shape (D, C) containing weights.
    - X: A numpy array of shape (N, D) containing a minibatch of data.
    - y: A numpy array of shape (N,) containing training labels; y[i] = c means
      that X[i] has label c, where 0 <= c < C.
    - reg: (float) regularization strength

    Returns a tuple of:
    - loss as single float
    - gradient with respect to weights W; an array of same shape as W
    """

    num_train = X.shape[0]
    num_classes = W.shape[1]

    # Initialize the loss and gradient to zero.
    loss = 0.0
    dW = np.zeros_like(W)

    #############################################################################
    # TODO: Compute the softmax loss and its gradient using explicit loops.     #
    # Store the loss in loss and the gradient in dW. If you are not careful     #
    # here, it is easy to run into numeric instability. Don't forget the        #
    # regularization!                                                           #
    #############################################################################
    # *****START OF YOUR CODE (DO NOT DELETE/MODIFY THIS LINE)*****

    for i in range(num_train):
      f_i = X[i].dot(W)
      f_i -= np.max(f_i)
      sum_j = np.sum(np.exp(f_i))

      loss += np.log(sum_j) - f_i[y[i]]

      for k in range(num_classes):
        dW[:, k] += ((np.exp(f_i[k])/sum_j) - (k == y[i])) *X[i]

    loss /= num_train
    dW /= num_train

    loss += reg * (W*W).sum()
    dW += reg * 2 * (W)
 

    # *****END OF YOUR CODE (DO NOT DELETE/MODIFY THIS LINE)*****

    return loss, dW


def softmax_loss_vectorized(W, X, y, reg):
    """
    Softmax loss function, vectorized version.

    Inputs and outputs are the same as softmax_loss_naive.
    """

    num_train = X.shape[0]
    num_classes = W.shape[1]
    # Initialize the loss and gradient to zero.
    loss = 0.0
    dW = np.zeros_like(W)

    #############################################################################
    # TODO: Compute the softmax loss and its gradient using no explicit loops.  #
    # Store the loss in loss and the gradient in dW. If you are not careful     #
    # here, it is easy to run into numeric instability. Don't forget the        #
    # regularization!                                                           #
    #############################################################################
    # *****START OF YOUR CODE (DO NOT DELETE/MODIFY THIS LINE)*****

    scores = X@W

    scores -= np.max(scores, axis=1, keepdims=True)

    scores_exp = np.exp(scores)
    sum_j = np.sum(scores_exp, axis=1, keepdims=True)
    
    loss = -(scores[np.arange(num_train), y]) + np.log(sum_j)
    loss = loss.mean()

    p = scores_exp / sum_j
    ind = np.zeros_like(p)
    ind[np.arange(num_train), y] = 1
    dW = X.T @ (p - ind)
    dW /= num_train
    dW += reg * 2* (W)

    # *****END OF YOUR CODE (DO NOT DELETE/MODIFY THIS LINE)*****

    return loss, dW
