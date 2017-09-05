#! /usr/bin/env python
# coding=utf-8
"""
-------------------------------------------------
File Name：     performance_test.py  
Description :  
Author :       Keefe Wu
date：         2017/1/17
refer:  http://python.jobbole.com/86822/
conclusion: cpu/io/http各种密集型的性能比较（按使用时间升序排）  
    cpu密集型: line>多进程>多线程；
    io密集型：多进程>line>多线程
    http密集型：多线程>多进程>line，推荐多线程。
结论：综合场景下，多进程是上述最优选择；但在网络请求场景下，首选多线程。
-------------------------------------------------
"""

import requests
import time
from threading import Thread
from multiprocessing import Process

REPEAT_NUM = 20

# 定义CPU密集的计算函数: 5万*3=15万次


def count_with_args(x, y):
    c = 0
    while c < 50000:
        c += 1
        x += x
        y += y

# 定义IO密集的文件读写函数：50万行


def write():
    f = open("test.txt", "w")
    for x in range(500000):
        f.write("testwrite\n")
    f.close()


def read():
    f = open("test.txt", "r")
    lines = f.readlines()
    f.close()

# 不带参数的测试函数：count2/io/http_request


def count():
    #count_with_args(1, 1)
    c = 0
    while c < 500000:
        c += 1


def io():
    write()
    read()

# 定义网络请求函数


def http_request():
    _head = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.116 Safari/537.36'}
    url = "http://www.tieba.com"
    try:
        webPage = requests.get(url, headers=_head)
        html = webPage.text
        return {"context": html}
    except Exception as e:
        return {"error": e}

# 测试线性执行三种操作所需时间


def line_test_more():
    # CPU密集操作
    t = time.time()
    for x in range(REPEAT_NUM):
        count()
        #count_with_args(1, 1)
    print("Line cpu", time.time() - t)

    # IO密集操作
    t = time.time()
    for x in range(REPEAT_NUM):
        io()
    print("Line IO", time.time() - t)

    # 网络请求密集型操作
    t = time.time()
    for x in range(REPEAT_NUM):
        http_request()
    print("Line Http Request", time.time() - t)

# 测试多线程并发执行CPU密集操作所需时间


def multithread_cpu_test():
    counts = []
    t = time.time()
    for x in range(REPEAT_NUM):
        thread = Thread(target=count_with_args, args=(1, 1))
        counts.append(thread)
        thread.start()

    e = counts.__len__()
    while True:
        for th in counts:
            if not th.is_alive():
                e -= 1
        if e <= 0:
            break
    print("multithread", time.time() - t)

# 线性执行，参数为函数名


def line_test(func):
    t = time.time()
    for x in range(REPEAT_NUM):
        func()
    #print("line %s: %f" %(func.__name__, time.time() - t))
    print("line", func.__name__, time.time() - t)

# 多线程并发，参数为函数名


def multithread_test(func):
    t = time.time()
    tasks = []
    t = time.time()
    for x in range(REPEAT_NUM):
        thread = Thread(target=func)
        tasks.append(thread)
        thread.start()

    e = tasks.__len__()
    while True:
        for th in tasks:
            if not th.is_alive():
                e -= 1
        if e <= 0:
            break
    print("multithread", func.__name__, time.time() - t)

# 多进程并发，参数为函数名


def multiprocess_test(func):
    tasks = []
    t = time.time()
    for x in range(REPEAT_NUM):
        process = Process(target=func)
        tasks.append(process)
        process.start()
    e = tasks.__len__()
    while True:
        for th in tasks:
            if not th.is_alive():
                e -= 1
        if e <= 0:
            break
    print("multiprocess", func.__name__, time.time() - t)


def line_compare(type=0):
    if type == 1:
        line_test(count)
    elif type == 2:
        line_test(io)
    elif type == 3:
        line_test(http_request)
    else:
        line_test(count)
        line_test(io)
        line_test(http_request)


def multithread_compare(type=0):
    if type == 1:
        multithread_test(count)
    elif type == 2:
        multithread_test(io)
    elif type == 3:
        multithread_test(http_request)
    else:
        multithread_test(count)
        multithread_test(io)
        multithread_test(http_request)


def multiprocess_compare(type=0):
    if type == 1:
        multiprocess_test(count)
    elif type == 2:
        multiprocess_test(io)
    elif type == 3:
        multiprocess_test(http_request)
    else:
        multiprocess_test(count)
        multiprocess_test(io)
        multiprocess_test(http_request)

if __name__ == '__main__':

    # line_test()
    type = 2
    line_compare(type)
    multithread_compare(type)
    multiprocess_compare(type)
