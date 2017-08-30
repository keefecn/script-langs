#!/usr/bin/env python 
# encoding: utf-8 
'''
@filename namespace.py
@author: keefe
@created: 2017/8/30
@beief: LEGB: Local function -->Enclosing function-->Global module-->Builtin
@see: 
'''

x = 1 
def foo(): 
    x = 2 
    def innerfoo(): 
        # x = 3 
        print 'locals ', x 
    innerfoo() 
    print 'enclosing function locals ', x 
        
foo() 
print 'global ', x
    
