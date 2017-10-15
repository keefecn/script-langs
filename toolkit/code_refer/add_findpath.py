# -*- coding: utf-8 -*-
'''
@file: add_findpath.py
@version: 1.0
@author: keefe
@date: 2017/10/1
@note: add currnet python module director to find path~ lib/site-packages/
'''
import os
import platform
import subprocess

PY_CMD = ''
CAT_CMD = ''


def do_cmd(cmd):
    print('cmd: %s' % cmd)
    handle = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE)
    res = handle.communicate()[0]
    print res
    return res

# judge dst_dir: windos~site-packages, linux~dist-packages
PY_WINDIR = "d:\\dev\\python\\python27.12_x86\\lib\\site-packages\\"
PY_LINUXDIR = '/usr/lib/python27/dist-packages/'
dst_dir = ''
dst_file = 'mypk.pth'

# judge os
CUR_OS = platform.system()
if 'Windows' in CUR_OS:  # Windows/linux
    PY_CMD = 'where python'
    CAT_CMD = 'type'
    # dst_dir = PY_WINDIR
    PY_DIR = do_cmd(PY_CMD)
    dst_dir = os.path.dirname(PY_DIR)
    dst_dir = dst_dir + os.sep + 'lib' + os.sep + 'site-packages'
else:
    PY_CMD = 'which python'
    CAT_CMD = 'cat'
    PY_DIR = do_cmd(PY_CMD)
    if '/usr/bin/python' in PY_DIR:  # linux
        PY_DIR = PY_DIR.strip()
        if os.path.islink(PY_DIR):
            python_v = os.readlink(PY_DIR)
            dst_dir = '/usr/lib/%s/dist-packages' % python_v
        else:
            dst_dir = PY_LINUXDIR
    else:
        dst_dir = os.path.dirname(PY_DIR)
        dst_dir = dst_dir + os.sep + 'lib' + os.sep + 'dist-packages'

# judge dst_file: if exist, then exit
module_dir = os.getcwd()
dst_file_abspath = dst_dir + os.sep + dst_file
if os.path.exists(dst_file_abspath):
    do_cmd('%s %s' % (CAT_CMD, dst_file_abspath))
    exit(0)

# do cmd
print(51, module_dir, dst_dir, dst_file)
echo_cmd = 'echo %s > %s' % (module_dir, dst_file_abspath)
do_cmd(echo_cmd)
