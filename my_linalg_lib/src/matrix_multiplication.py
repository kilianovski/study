import os

def matmul(A, B):
    C = []
    
    for i in range(len(A)):
        C.append([None]*len(A[i]))
        for j in range(len(B)):
            C[i][j] = 0
            for k in range(len(A[i])):
                C[i][j] += A[i][k] * B[k][j]
    return C

def read_matricies():
    with open('src/matricies.txt', 'r') as f:
    content = f.read()
        
    global_i=0
    content=content.split()
    m,n,p = list(map(int, content[global_i].split(',')))
    global_i+=1

    A = []
    for _ in range(m):
        row = list(map(float, content[global_i].split(',')))
        A.append(row)
        global_i+=1

    B = []
    for _ in range(n):
        row = list(map(float, content[global_i].split(',')))
        B.append(row)
        global_i+=1    
        
    C = []
    for _ in range(m):
        row = list(map(float, content[global_i].split(',')))
        C.append(row)
        global_i+=1

    A = np.array(A)
    B = np.array(B)
    C = np.array(C)

    assert np.all(np.isclose(A@B, C))

    return A,B,C

if __name__ == '__main__':
    A,B,C = read_matricies()
    for _ in range(100):
        


