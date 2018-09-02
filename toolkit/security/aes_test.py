#!/usr/bin/env python
# -*- coding: utf-8 -*-
'''
@author: keefe
@date: 2017/10/1
@dependary:  pip install pycrypto
'''

import os
import base64

from Crypto.Cipher import AES

BLOCK_SIZE = 16
PADDING = '\0'
pad_it = lambda s: s+(16 - len(s)%16)*PADDING  
key = 'B31F2A75FBF94099'
iv = '1234567890123456'

#使用aes算法，进行加密解密操作
#为跟java实现同样的编码，注意PADDING符号自定义
def encrypt_aes(sourceStr):
    generator = AES.new(key, AES.MODE_CBC, iv)
    crypt = generator.encrypt(pad_it(sourceStr))
    cryptedStr = base64.b64encode(crypt)
    return cryptedStr

def decrypt_aes(cryptedStr):
    generator = AES.new(key, AES.MODE_CBC, iv)
    cryptedStr = base64.b64decode(cryptedStr)
    recovery = generator.decrypt(cryptedStr)
    decryptedStr = recovery.rstrip(PADDING)
    return decryptedStr

sourceStr = 'password^*(&( 09-8ADF'


print (encrypt_aes(sourceStr))
print (decrypt_aes(encrypt_aes(sourceStr)))