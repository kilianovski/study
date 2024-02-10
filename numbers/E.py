def klever_permutation(n,k):
    p = [-1 for _ in range(n)]
    i = 0
    start = 1

    for a in range(1, n+1):
        p[i] = a
        

        if i + k < n:
            i = i + k
        else:
            i = start
            start += 1

    return p


def line2list(line): return list(map(int, line.split()))


T = int(input())

rr = []
for _ in range(T):
    n, k = line2list(input())
    p = klever_permutation(n,k)
    
    r = " ".join([str(x) for x in p])
    print(r)
    # rr.append(r)


# for r in rr:
#     print(r)

