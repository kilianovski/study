from random import randrange, uniform
import math

def grad_check_sparse(f, x, analytic_grad, num_checks=10, h=1e-5):
    """
    sample a few random elements and only return numerical
    in this dimensions.
    """

    for i in range(num_checks):
        
        if isinstance(x, list):
            ix = randrange(len(x))
            arg = x[ix]
        else:
            ix = tuple([randrange(m) for m in x.shape])
            arg = x
            
        oldval = arg
        arg = oldval + h # increment by h
        fxph = f(arg) # evaluate f(x + h)
        arg = oldval - h # increment by h
        fxmh = f(arg) # evaluate f(x - h)
#         x[ix] = oldval # reset

        grad_numerical = (fxph - fxmh) / (2 * h)
        
        grad_analytic = analytic_grad[ix]
        if math.isclose(grad_analytic, grad_numerical, abs_tol=1e-2) or (math.isclose(grad_analytic, 0.0) and math.isclose(grad_numerical, 0.0)):
            rel_error = 0.0
        
        else:
            rel_error = (abs(grad_numerical - grad_analytic) /
                    (abs(grad_numerical) + abs(grad_analytic)))
        
        hr_res = 'BAD!' if rel_error > 1e-3 else 'Good.'
        print(f'{hr_res} numerical: %f analytic: %f, relative error: %e'
              %(grad_numerical, grad_analytic, rel_error))


def check_derivative(f, dfdx, X=None):
    if X is None:
        num_samples=10
        X = [uniform(-1e2, 1e2) for _ in range(num_samples//2)]+ [uniform(-1e0, 1e0) for _ in range(num_samples//2)]


    
    grad = [dfdx(x) for x in X]
    
    grad_check_sparse(f, X, grad)