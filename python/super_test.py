#!/usr/bin/env python 
# encoding: utf-8 
'''
@filename super_test.py
@author: keefe
@created: 2017/8/30
@see: 
'''

class A(object):
    def go(self):
        print "go A go!"

    def stop(self):
        print "stop A stop!"

    def pause(self):
        raise Exception("Not Implemented")


class B(A):

    def go(self):
        super(B, self).go()
        print "go B go!"


class C(A):

    def go(self):
        super(C, self).go()
        print "go C go!"

    def stop(self):
        super(C, self).stop()
        print "stop C stop!"


class D(B, C):  # 从右到左执行父类

    def go(self):
        super(D, self).go()
        print "go D go!"

    def stop(self):
        super(D, self).stop()
        print "stop D stop!"

    def pause(self):
        print "wait D wait!"


class E(B, C):
    pass

print 'start'
a = A()
b = B()
d = D()
e = E()
c = C()

a.go()
b.go()
c.go()
d.go()
e.go()

a.stop()
