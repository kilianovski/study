# Structuring Machine Learning Projects Course

by deeplearning.ai


1. Orthogonalization. Don't tune things that affect each other at once
1. SOTA Face verification systems are not end-to-end
1. Satisficing and Optimizing metrics

Good summary: [link](https://github.com/mbadry1/DeepLearning.ai-Summary/tree/master/3-%20Structuring%20Machine%20Learning%20Projects)

## Motivation

Why take this course?

This course is about ML strategy

In ML there are so many things to try in order to improve your results:

- collect more data
- select different optimizer
- apply regularization
- try different type of model
- etc.

You can spend your time doing things that doesn't lead to good improvements.

So, from this course I want to learn, how to establish the best strategy and tackle experiments:

1. How should I choose strategy
1. How structure ideas I want to try in the future
1. What are prerequisites before doing experiments (established validation?) 
1. What are the rules (checklist) for doing experiment in your work?

## Orthogonalization

### Two examples of orthogonalization in real world

1. Old TV with knobs to adjust an image
    1. Picture width
    1. Picture height
    1. Picture rotation
    1. Up/Down
    1. Left/Right
    1. Adjust how trapezoidal picture is
2. Controls in car
    1. Steering to control the **angle**
    1. Acceleration and braking pedals to control the **speed**

What if these knobs were not for one things, but affected the other things?

E.g. knobs:
1. `1.1*angle + 0.7*speed`
1. `0.6*angle - 2.2*speed`

With this set of vectors it is still possible to reach the required whole space of possible actions.

But.

It is more convenient when these knobs are orthogonal to each other (and normalized also :) )


### ML flow and orthogonalization

We usually have these milestones in ML project:

1. Fit training set well on the cost function
1. Fit validation set well on the cost function
1. Fit training set well on the cost function (or your metric)
1. Perform well in a real world (less formal feedback from users of the system)

For each of these stages we have different knobs.

1. To fit train better, we may
    1. Model with more capacity
    1. Different optimizer algo
    1. ...
1. To fit the valid set (after we fit train), we may
    1. Add regularization
    1. Increase train set
1. To do fit the test set, we may, for example, increase valid set
1. To fit the real world, we may
    1. Check cost function
    1. Check your data

## 1. Setting up your goal

### Single number evaluation metric

When selecting the model among a lot of models, it is hard to compare them by a lot of numbers.

Try to setup single real number metric to compare models

### Satisficing and Optimizing metric

If you care about multiple things at once:

1. Classifier accuracy and running time
1. Wakewords accuracy and #false positives

You can choose one metric as **optimizing**  - order models by it

Other ones as **satisficing** - threshold by them (e.g. classifier should run faster than 100ms)

### train/valid/test distribution

Your validation should reflect the test set (real world set)

### Size of the dev and test sets

70/30 or 60/20/20 splits are not the rules carved in stone.

It is ok to do 98/1/1 if dataset is reasonably big. You evaluate on 10,000 samples and confident enough.

### When to change sets and metrics

If ranking by your metric does not satisfy you, consider revisiting metric and data.

E.g. **punish harder** for classifying porn images as cats.

Andrew Ng advices to think **separately** on these **distinct** steps:

1. Defining a metric
1. How to do well on this metric

It is better to have **validation set** and not-perfect **metric** than nothing.


## 2. Comparing to human-level performance

### Bayes optimal error

Best possible error. Some theoretical optimum of performance.

After reaching human-level performance, there are two main reasons of progress slow-down:

1. HLP is usually not so far from Bayes optimal error
2. You can't use a lot of tactics for improvement anymore:
  1. Getting labels from humans
  1. Insights from manual error analysis
  1. Better analysis of bias/variance

### Avoidable bias

Difference between training error and bayes error.

Humans are bad at non natural-perception tasks.

## 3. Error analysis

### Carrying out error analysis

If you want to do improve your models out of mislabeled data, first determine a "ceiling" for this improvement.

If only 5 / 100 mislabeled photos are dogs, _completely_ solving dog problem will boost you only for 5%

1. Find mislabeled examples
1. Count up what categories (e.g. Blurry images, instagram filters, dogs) for mislabeled