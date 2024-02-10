def is_possible_to_choose(A,B,k):
    A_cap_R = [0 for _ in range(k)]
    A_cap_R_len = 0

    for a in A:
        if a <= k and not A_cap_R[a-1]:
            A_cap_R[a-1] = 1
            A_cap_R_len += 1

    B_cap_R_len = 0
    R_coverage = A_cap_R_len

    for b in B:
        if b <= k and A_cap_R[b-1] < 2:
            if A_cap_R[b-1] == 0:
                R_coverage += 1

            A_cap_R[b-1] = 2
            B_cap_R_len += 1


    return A_cap_R_len >= k//2 and B_cap_R_len >= k//2 and R_coverage==k

def mikes_solution(a, b, k):
    # Main idea:
    # cA/cB = num of values only in A/B gives the condition
    # cA + cB + cAB < k
    
    c = [0 for _ in range(k+1)]
    
    for e in a:
        if e <= k:
            c[e] |= 1
    for e in b:
        if e <= k:
            c[e] |= 2
            
    count = [0] * 4
    
    for e in c[1:]:
        # 0 - not in a and not in b
        # 1 - only in a
        # 2 - only in b
        # 3 - in a and in b
        
        if e == 0: return False
        count[e] += 1
    
    if count[1] > k//2 or count[2] > k//2 or sum(count) != k:
        return False
    else:
        return True

DEBUG = False

T = int(input())

def line2list(line): return list(map(int, line.split()))


result = []
for _ in range(T):
    n, m, k = line2list(input())
    a = line2list(input())
    b = line2list(input())
    
    
    r = mikes_solution(a,b,k)
    r = "YES" if r else "NO"
    if DEBUG:
        result.append(r)
    else:
        print(r)


if DEBUG:
    print('*'*100)
    for r in result: print(r)
