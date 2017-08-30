# coding:utf-8
'''
@filename decorator.py
@author: keefe
@created: 2017/8/30
@see: 
'''

__author__ = 'keefe wu'

import time
 
# test 1: waste time
# function derator: used in log/wastetime
def timeit(func):
    def wrapper():
        start = time.clock()
        func()
        end = time.clock()
        print 'used:', end - start
    return wrapper

@timeit
def time_foo():
    print 'in time_foo()'


# test 2: @
def decorator(func):
    def wrapper(*arg, **kwargs):
        print '%s is runing' % func  # .__name__
        return func(*arg, **kwargs)
    return wrapper

def a(arg):
    pass
def b(arg):
    pass
@decorator
def c(arg):
    pass

a = decorator(a)
# b=decorator(b)
# c=decorator(c)

a('fuck a')
b('fuck b')
c('fuck c')

# test 3: log
# no args
def use_logging(func): 
    def wrapper(*args, **kwargs): 
        # logging.warn("%s is running" % func.__name__) 
        print("%s is running" % func.__name__)
        return func(*args, **kwargs) 
    return wrapper

# with args
def use_logging2(level): 
    def decorator(func):
        def wrapper(*args, **kwargs): 
            # logging.warn("%s is running" % func.__name__) 
            print("%s is running: %s" % (func.__name__, level))
            return func(*args)
        return wrapper
    return decorator

@use_logging
def log_bar(): 
    print("i am log_bar") 
      
@use_logging2(level="warn")    
def log_bar2(): 
    print("i am log_bar2")
    
     
# test 4: class 
class Rabbit(object):
     
    def __init__(self, name):
        self._name = name
        print '__init__ %s' % name
     
    # instance_method
    def instance_method(self, name):
        print 'instance_method ' + name
         
    @staticmethod
    def static_method(name):
        return Rabbit(name)
     
    @classmethod
    def class_method(cls):
        return Rabbit('')
     
    # @property
    def name(self):
        return self._name
        

if __name__ == "__main__": 
    # funtion decorator
    print '\n--funtion decorator...'    
    # time_foo()  # no args: 
    log_bar()  # no args
    log_bar2()  # with args
    
    # class decorator
    print '\n--class decorator...'
    Rabbit.static_method('static 1')
    Rabbit.class_method()
    # print Rabbit.name()
    aRabbit = Rabbit('good');
    aRabbit.instance_method('instance')
    aRabbit.static_method('static 2')
    aRabbit.class_method()  
    
    import types  
    print isinstance(Rabbit.static_method, types.FunctionType)
    print isinstance(Rabbit.instance_method, types.MethodType)    
    print isinstance(range, types.BuiltinFunctionType)     
    # print types(Rabbit.static_method)  
    # Rabbit.name()    
