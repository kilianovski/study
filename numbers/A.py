n = int(input())

for _ in range(n):
    _ = input()
    segment = input()
    first = 0
    while first < len(segment) and segment[first] != "B":
        first += 1

    last = len(segment) - 1
    while last >= 0 and segment[last] != "B":
        last -= 1

    print( max(0, last - first + 1) )
