from collections import defaultdict
import string


def decode_trace(trace):
    counts = defaultdict(list)
    counts[0] = list(string.ascii_lowercase)


    result = []
    for a in trace:
        char = counts[a].pop()

        counts[a+1].append(char)
        result.append(char)
        
    return "".join(result)


def line2list(line): return list(map(int, line.split()))

t = int(input())

rr = []
for _ in range(t):
    _ = input()
    
    trace = line2list(input())
    
    s = decode_trace(trace)
    print(s)
    
#     rr.append(s)
    
# print('*'*100)
# print(rr)
