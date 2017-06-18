def solution(input):
       p = (input[len(input)-1] - input[0]) / len(input)
       for i in range(0, len(input)):
           if(input[i]+p != input[i+1]):
               return input[i]+p

def solution2(input):
       diff1 = input[1] - input[0]
       diff2 = input[2] - input[1]
       div1 = input[1]*1.0 / input[0]
       div2 = input[2]*1.0 / input[1]
       type = ""
       p = 0
       if(diff1 == diff2):
           type = "Arithmetic"
           p = diff1
       elif(diff1 == diff2*2 or diff1*2 == diff2):
           type = "Arithmetic"
           p = min(diff1,diff2)
       elif(div1 == div2):
           type = "Geometric"
           p = div1
       else:
           type = "Geometric"
           p = min(div1, div2)
       for i in range(0, len(input)):
           if(type == "Arithmetic" and input[i]+p != input[i+1]):
               return input[i]+p
           if(type == "Geometric" and input[i]*p != input[i+1]):
               return input[i]*p
}
