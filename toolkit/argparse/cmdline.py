#!/usr/bin/env python
#-*- coding: utf-8 -*-
'''
@desc: gamespider
@version: 1.0
@author: Keefe
@date: 2017/10/6
@note:  "ho:v"  --> -h -o [] -v 
'''

def parse_args():
    import sys
    for item in sys.argv:
            print item

def usage ():
    usage_str = """
Usage: cmdline.py [options]  
Options: 
  -h, --help            show this help message and exit  
  -v, --verbose         silent output  
  -o, --output          output file
    """
    print(usage_str)

def argparse_main():
    import argparse
    parser = argparse.ArgumentParser(description='topic spider')
    parser.add_argument('-v', "--verbose", dest='verbose',
                        action='store_true', help='show version')
    parser.add_argument('-o', '--output', help='output file')
    # 没有-开头的为必选参数, dest指向执行的函数
    parser.add_argument('integers', metavar='N', type=int, nargs='+',
                        help='an integer for the accumulator')
    # dest: dest function, such as accumulate, sum
    parser.add_argument('--sum', dest='accumulate', action='store_const',
                        const=sum, default=max,
                        help='sum the integers (default: find the max)')
    parser.add_argument('--version', action='version', version='%(prog)s 2.0')
    args = parser.parse_args()
    print args.accumulate(args.integers)
    print( parser.parse_args(['--version']))


def optparse_main():
    from optparse import OptionParser
    parser = OptionParser(description='topic spider')
    parser.add_option("-v", "--verbose", action="store_true",
                      dest="verbose", help='silent output')
    parser.add_option("-o", action="store_false", dest="output", help='output file')
    (opts, args) = parser.parse_args()
    print(opts, args)


def getopt_main():
    import getopt, sys
    try:
        opts, args = getopt.getopt(sys.argv[1:], "ho:v", ["help", "output="])
        print(opts, args)
    except getopt.GetoptError as err:
        # print help information and exit:
        print str(err)  # will print something like "option -a not recognized"
        usage()
        sys.exit(2)
    output = None
    verbose = False
    for o, a in opts:
        if o == "-v":
            verbose = True
        elif o in ("-h", "--help"):
            usage()
            sys.exit()
        elif o in ("-o", "--output"):
            output = a
        else:
            usage()
            assert False, "unhandled option"


if __name__ == '__main__':

    #funcs = [parse_args, argparse_main, optparse_main, getopt_main]
    funcs = [argparse_main, optparse_main, getopt_main]
    for func in funcs:
        print('START %s' %func.__name__)
        func()
            