#! /usr/bin/env python
# coding=utf-8
"""
File Name：     api_asyn.py
Description :  API异步/同步请求
Author :       Keefe Wu
date：         2019/12/14
"""

import  pandas  as pd

def get_testcases(file_path, url=''):
    """ 获取要测试的数据"""
    sheet=pd.read_excel(file_path)
    testcases = []
    for row in sheet:
        if url != sheet['url']:
            continue
        result.append(row)
    return result

def do_one_api():
    pass

def do_apis():
    pass


if __name__ == '__main__':
    pass