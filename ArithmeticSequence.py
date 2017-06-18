{\rtf1\ansi\ansicpg1252\cocoartf1504\cocoasubrtf810
{\fonttbl\f0\fnil\fcharset0 Menlo-Regular;}
{\colortbl;\red255\green255\blue255;\red0\green0\blue0;\red255\green255\blue255;}
{\*\expandedcolortbl;;\cssrgb\c0\c0\c0;\csgenericrgb\c100000\c100000\c100000;}
\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\deftab720
\pard\pardeftab720\sl320\partightenfactor0

\f0\fs28 \cf2 \cb3 \expnd0\expndtw0\kerning0
\outl0\strokewidth0 \strokec2    def solution(input):\
       p = (input[len(input)-1] - input[0]) / len(input)\
       for i in range(0, len(input)):\
           if(input[i]+p != input[i+1]):\
               return input[i]+p\
\
\pard\pardeftab720\sl320\partightenfactor0
\cf2 def solution2(input):\
       diff1 = input[1] - input[0]\
       diff2 = input[2] - input[1]\
       div1 = input[1]*1.0 / input[0]\
       div2 = input[2]*1.0 / input[1]\
       type = ""\
       p = 0\
       if(diff1 == diff2):\
           type = "Arithmetic"\
           p = diff1\
       elif(diff1 == diff2*2 or diff1*2 == diff2):\
           type = "Arithmetic"\
           p = min(diff1,diff2)\
       elif(div1 == div2):\
           type = "Geometric"\
           p = div1\
       else:\
           type = "Geometric"\
           p = min(div1, div2)\
       for i in range(0, len(input)):\
           if(type == "Arithmetic" and input[i]+p != input[i+1]):\
               return input[i]+p\
           if(type == "Geometric" and input[i]*p != input[i+1]):\
               return input[i]*p\
\pard\pardeftab720\sl320\partightenfactor0
\cf2 \
\
}