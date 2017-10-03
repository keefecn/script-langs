# -*- coding: utf-8 -*-
'''
@author: keefe
@date: 2017/10/2
@note: check bytes stored sequence
0x12345678 -- 
address stored left is high address
big-endian: low byte stored in high address, Eg, 0x12345678 -> 78 56 34 12
little-endian: low byte stored in low address, Eg. 0x12345678 --> 12 34 56 79
network: tcp/ip use big-endian.
'''

def check_endian ():
    import struct
    val = 0x12345678
    pk = struct.pack('i', val)
    hek_pk = hex(ord(pk[0]))
    if hek_pk == '0x78':
        print('little endian')
    elif hek_pk == '0x12':
        print('big endian')
    else:
        print('bad check_endian', hek_pk)
    print(hex(ord(pk[0])), pk[1], pk[2], pk[3])

if __name__ == "__main__":
    check_endian()
