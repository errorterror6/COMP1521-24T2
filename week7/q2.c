
    0x0013
    = 1* 16^1 + 3* 16 ^0
    = 16 + 3
    = 19

    0x0444
    = 4 * 16^2 + 4* 16 ^1 + 4*16 ^0
    = 1092

    0x1234
    0b 0001
    sign : +
    = 1* 16^3 + 2* 16^2 + 3* 16^1 + 4* 16^0
    = 4660


    0xffff
    0b 1111 1111 1111 1111
    //do 2's complement to convert from neg to positive
    0b 0000 0000 0000 0000    //step 1: take not operation
    0b 0000 0000 0000 0001    //step 2: add 1.
    result = -1


    0x8000 
    0b 1000 0000 0000 0000    <<signed
    0b 0111 1111 1111 1111  //not operation
    0b 1000 0000 0000 0000    <<unsigned  //we can interpret this as a uint.

    1 * 2^15
    = 32768
    //because it is negative
    result = -32768