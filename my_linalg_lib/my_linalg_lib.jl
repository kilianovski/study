using Base

function my_matmul(A, B)
    m, n = size(A)
    n, p = size(B)
    C = Array{Float64}(undef, m, p)
    for i in 1:m
        for j in 1:p
            C[i, j] = 0
            for k in 1:n
                C[i, j] += A[i, k]*B[k, j]
            end
        end
    end
    return C
end

A = [1 2
     3 4]

B = [-1 0
     0 -1]

C_expected = [-1 -2
              -3 -4]

@assert A * B == C_expected
@assert my_matmul(A, B) == C_expected