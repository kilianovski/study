import numpy as np

def generate_matricies_to_multiply(m=100, n=100, p=100):
    np.random.seed(42)

    A = np.random.randn(m, n)
    B = np.random.randn(n, p)

    C = A@B

    file_content = f"{m},{n},{p}\n"

    for row in A:
        file_content+=",".join(map(str , list(row)))
        file_content+="\n"
    for row in B:
        file_content+=",".join(map(str , list(row)))
        file_content+="\n"
    for row in C:
        file_content+=",".join(map(str , list(row)))
        file_content+="\n"
          
    with open('src/matricies.txt', 'w') as f:
        f.write(file_content)

def generate_system_of_lin_equations(n=100):
    np.random.seed(42)
    A = np.random.randn(n, n)
    b = np.random.randn(n, 1)

    x = np.linalg.solve(A, b)
    
    assert np.all(np.isclose(A@x, b))

    file_content = f"{n}\n"

    for row in A:
        file_content+=",".join(map(str , list(row)))
        file_content+="\n"
        
    file_content+=",".join(map(str , list(b.reshape(-1))))   


    with open('src/system_of_lin_eq.txt', 'w') as f:
        f.write(file_content)

if __name__ == '__main__':
    generate_system_of_lin_equations(3)
    generate_matricies_to_multiply()