{\rtf1\ansi\ansicpg1252\cocoartf1504\cocoasubrtf810
{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 def add_0(x,y):\
    return bin (int(x,2) + int(y,2))\
\
def add(x,y):\
        maxlen = max(len(x), len(y))\
\
        #Normalize lengths\
        x = x.zfill(maxlen)\
        y = y.zfill(maxlen)\
\
        result = ''\
        carry = 0\
\
        for i in range(maxlen-1, -1, -1):\
            r = carry\
            r += 1 if x[i] == '1' else 0\
            r += 1 if y[i] == '1' else 0\
\
            # r can be 0,1,2,3 (carry + x[i] + y[i])\
            # and among these, for r==1 and r==3 you will have result bit = 1\
            # for r==2 and r==3 you will have carry = 1\
\
            result = ('1' if r % 2 == 1 else '0') + result\
            carry = 0 if r < 2 else 1       \
\
        if carry !=0 : result = '1' + result\
\
        return result.zfill(maxlen)\
        # return result\
\
print add_0('1','111')        \
print add('1','111')}