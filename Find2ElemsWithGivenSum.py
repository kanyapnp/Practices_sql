def solution(input, sum):
    for i in range(0, len(input)):
        for j in range(1, len(input)):
            if (input[i] + input[j] == sum):
                return True
    return False

def solution2(input, sum):
    sorted(input)
    i = 0
    j = len(input) - 1
    
    while (i < j):
        total = input[i] + input[j]
        if (total == sum):
            return True
        elif (total > sum):
            j=j-1
        elif (total < sum):
            i=i+1
    return False        

def solution3(input, sum):
    dic = {}
    for i in range(0,len(input)):
        # l_key = sum-input[i]
        # i_key = input[i]
        if (dic.get(sum-input[i])):
            return True
        dic[input[i]] = True
    return False
    

print solution3([1,2,4], 3)
