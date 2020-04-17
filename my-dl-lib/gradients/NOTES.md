# explained.ai/matrix-calculus

## Jacobian

We can organize partial derivatives of many into a matrix. **Jacobian matrix**

## Derivatives of vector element-wise binary operators

In general, element-wise binary operation is:

```
y = f(w) O g(x)
```

### When do we reduce Jacobian to diagonal matrix?

if fi(w) is constant with respect to wj

Usually f(w) is just w in EWBO.

## Vector sum reduction

They define it as `sum(f(x))`. Over the results, not the parameter.

Lets look at simple case, when f(x) = x: sum(x)

gradient is:

[ sum(dxi/dx1), sum(dxi/dx2) .. ]

Because dxi/dxj = 0 for i != j, we have:

[ dx1/dx1, dx2/dx2 .. ] = [1, 1 .. ]

## The Chain Rule(s)

### Single-variable chain rule

dy/dx = dy/du * du/dx

Algorithm:

1. Set intermediate variables
2. Compute each derivative with respect to params
3. Combine it with multiplication
4. Substitute back

### Total derivative

Lets us compute functions like `f(t, x(t), y(t))`

u(x) = x * x

y(x, u(x)) = x + u(x)

dy/dx = dy/dx * dx/dx + dy/du * du/dx = 1 + 1 * 2x

- The total derivative assumes all variables are potentially codependent
- the partial derivative assumes all variables but x are constants.

### Single-variable total derivative chain rule

f(x) = sin(x + x^2)

1. Introduce intermediates

u1(x) = x^2

u2(x, u1) = x + x^2

u3 (u2) = sin(u2)

2. Compute derivatives

u1(x) = x^2             | du1/dx  = 2x

u2(x, u1) = x + u1      | du2/dx  = du2/dx * dx/dx + du2/du1 * du1/dx =  1 + 1 * 2x

u3 (u2) = sin(u2)       | du3/du2 = cos(u2)

3. Combine with multiplication

du3/dx = du3/du2 * du2/dx = cos(u2) * (1 + 2x) 

4. Substitute

= cos(x + x^2) * (1 + 2x)

### Vector chain rule

- Jacobian is a product of two other Jacobians
