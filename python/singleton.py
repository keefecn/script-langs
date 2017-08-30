# coding:utf-8
'''
@filename singleton.py
@author: keefe
@created: 2017/8/30
@see: 
'''
__author__ = 'keefe wu'

def show_result(cls, num):
    one = cls()  
    two = cls()  
    
    two.a = 3  
    print 'singlton %d start.' % num
    print one.a 
    print id(one)  
    print id(two)  
    
# class 1
class Singleton(object):  
    def __new__(cls, *args, **kw):  
        if not hasattr(cls, '_instance'):  
            orig = super(Singleton, cls)  
            cls._instance = orig.__new__(cls, *args, **kw)  
        return cls._instance  
  
class MyClass(Singleton):  
    a = 1  
  

# class 2
class Borg(object):  
    _state = {}  
    def __new__(cls, *args, **kw):  
        ob = super(Borg, cls).__new__(cls, *args, **kw)  
        ob.__dict__ = cls._state  
        return ob  
  
class MyClass2(Borg):  
    a = 1  
    
# class 3
# 方法3:本质上是方法1的升级（或者说高级）版  
# 使用__metaclass__（元类）的高级python用法  
class Singleton2(type):  
    def __init__(cls, name, bases, dict):  
        super(Singleton2, cls).__init__(name, bases, dict)  
        cls._instance = None  
#    def __call__(cls, *args, **kw):  
#        if cls._instance is None:  
#            cls._instance = super(Singleton2, cls).__call__(*args, **kw)  
#        return cls._instance  
  
class MyClass3(object):  
    __metaclass__ = Singleton2  
  
# class 4

  
show_result(MyClass, 1);
show_result(MyClass2, 2);
# show_result(MyClass3, 3);
# show_result(MyClass4, 4);
