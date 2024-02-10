def line2list(line): return list(map(int, line.split()))


T = int(input())

def process_query(a, l, r):
    for i in range(l-1, r):
        for j in range(i+1, r):
            if a[i] != a[j]: return i+1,j+1

    return -1,-1

result = []
for _ in range(T):
    
    _ = input()
    a = line2list(input())
    
    q = int(input())
    
    for _ in range(q):
        l,r = line2list(input())
        
        i,j = process_query(a, l, r)
        
        r = f'{i} {j}'
        print(r)
        # result.append(r)
    print()
    
# print('*'*100)
# print(result)
