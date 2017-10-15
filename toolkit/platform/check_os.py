#! /usr/bin/env python
# -*- coding: utf-8 -*-
'''
@desc:
@author: Denny
@date: 2017/10/2
@note:
'''


def print_os():
    import os
    print('os.name = %s' % os.name)  # nt/posix
    print('os.sep = %s' % os.sep)    # \ or /
    print('os.extsep = %s' % os.extsep)
    print('os.altsep = %s' % os.altsep)
    print('os.pathsep = %s' % os.pathsep)    # ;
    print('os.linesep = %s' % os.linesep)    # \r\n
    # print('os.environ = %s' %os.environ)
    print('os.curdir = %s' % os.curdir)
    print('os.pardir = %s' % os.pardir)


def print_platform():
    import platform
    print('\nplatform.uname = %s' % str(platform.uname()))
    '''Return: a tupleof strings (system,node,release,version,machine,processor)
    output: ('Windows', 'Lenovo-PC', '8.1', '6.3.9600', 'AMD64', 'Intel64 Family 6 Model 69 Stepping 1, GenuineIntel')
    '''
    print('platform.system = %s' % platform.system())
    print('platform.node = %s' % platform.node())
    print('platform.release = %s' % platform.release())
    print('platform.version = %s' % platform.version())
    print('platform.machine = %s' % platform.machine())
    print('platform.processor = %s' % platform.processor())
    print('platform.platform = %s' %
          platform.platform())  # Windows-8.1-6.3.9600


def print_platform_python():
    import platform
    print('\nplatform.python_version = %s' % platform.python_version())
    print('platform.python_compiler = %s' % platform.python_compiler())
    print('platform.python_implementation = %s' %
          platform.python_implementation())
    print('platform.python_build = %s' % str(platform.python_build()))
    print('platform.python_version_tuple = %s' %
          str(platform.python_version_tuple()))
    print('platform.java_ver = %s' % str(platform.java_ver()))
    # print('platform.java_ver = %s' %platform.java_ver())


def check_os():
    import platform
    CUR_OS = platform.platform
    if 'Windows' in CUR_OS:  # windows
        pass


if __name__ == "__main__":
    print_os()
    print_platform()
    print_platform_python()
