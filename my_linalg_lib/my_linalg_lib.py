def matmul(A, B):
    C = []
    
    for i in range(len(A)):
        C.append([None]*len(A[i]))
        for j in range(len(B)):
            C[i][j] = 0
            for k in range(len(A[i])):
                C[i][j] += A[i][k] * B[k][j]
    return C

A = [[1, 2], [3, 4]]
B = [[1, 0], [0, 1]]

C_expected = [[1, 2], [3, 4]]

assert matmul(A, B) == C_expected
