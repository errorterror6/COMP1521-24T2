
    2.5
    2.5 = (1+frac) * 2^n
    largest 2^n = 2^1 = 2
    2.5 = (1+frac) * 2
    2.5/2 = (1+frac)
    1.25 = 1+frac
    1*2^0 + 1*2^-2 = 1+frac
    1.frac = 1.01

    exp + bias = 1
    exp = 128

    sign : +

    0 10000000 00000000000000000000000
            
    0.375 = (1.frac) * 2^n
    greatest pow of 2 = 0.25 (2^-2)
    0.375/0.25 = (1.frac)
    1.frac = 1.5 = 0b 1.100000000000

    exp + bias= -2
    exp = 125

    0 01111101 10000000000000000000000


    27.0 = (1.frac) * 16  <<2^4
    27/16 = 1.frac
    1.6875 = 1.frac
    1.6875 = 1 + 0.5 + 0.125 + 0.0625
            = 1 + 2^-1 + 2^-3 + 2^-4
            1.10110000000000000
    exp = 4
    exp - bias = 131


    0 1000011 10110000000000000000000
    
    - 100.0 
    100 = (1.frac) * 64   < 2^6
    sign: 1
    exp + bias = 6
    exp = 133
    1.frac = 1.5625
    1.frac = 1 + 0.5 + 0.0625
    = 2^0 + 2^-1 + 2^-4
    1.100100000000000000000000000

    total:

    float c = 100;
    float f= 1100001100000100100000000000000000000000
    printf("%f", f)
    e.g. mul your exp by 1025
    e.g. change the 1.frac to be what comes in on the input line.

    100001100000 >> 11111111

    1 11111111 000000000000000000000000