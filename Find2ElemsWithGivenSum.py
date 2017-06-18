{\rtf1\ansi\ansicpg1252\cocoartf1504\cocoasubrtf810
{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 # Hello World program in Python\
    \
def solution(input, sum):\
    for i in range(0, len(input)):\
        for j in range(1, len(input)):\
            if (input[i] + input[j] == sum):\
                return True\
    return False\
\
def solution2(input, sum):\
    sorted(input)\
    i = 0\
    j = len(input) - 1\
    \
    while (i < j):\
        total = input[i] + input[j]\
        if (total == sum):\
            return True\
        elif (total > sum):\
            j=j-1\
        elif (total < sum):\
            i=i+1\
    return False        \
\
def solution3(input, sum):\
    dic = \{\}\
    for i in range(0,len(input)):\
        # l_key = sum-input[i]\
        # i_key = input[i]\
        if (dic.get(sum-input[i])):\
            return True\
        dic[input[i]] = True\
    return False\
    \
\
print solution3([1,2,4], 3)\
\
\
}