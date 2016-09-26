#!/usr/bin/python
#run: python debug_demo.py

_DEBUG=True
def debug_demo(val):
    if _DEBUG == True:
        import pdb
        pdb.set_trace()
    if val <= 1600 :
        print "level 1"
        print 0
    elif val <= 3500 :
        print "level 2"
        print (val - 1600) * 0.05
    elif val <= 6500 :
        print "level 3"
        print (val - 3500) * 0.10 + (3500-1600) * 0.05
    else:
        print "level 4"
        print (val - 6500) * 0.20 + (6500-3500) * 0.10 + (3500-1600) * 0.05


#~def debug_demo
if __name__ == "__main__":
    debug_demo(4500)
