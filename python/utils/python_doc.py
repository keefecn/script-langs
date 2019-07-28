#!/usr/bin/env python
# -*-coding: utf-8 -*-
'''
@summary: doc string
@author: Keefe Wu
@since: 2017-10-29
@note:
文档快速生成注释的方法介绍,首先我们要用到__all__属性
在Py中使用为导出__all__中的所有类、函数、变量成员等
在模块使用__all__属性可避免相互引用时命名冲突
suppoer 3 tag syntax: epytext/javadoc/rest
@see: https://docs.python.org/2.7/search.html?q=TestCase
python快速生成注释文档的方法  http://www.cnblogs.com/cookie1026/p/6093188.htm
'''
__all__ = ['Login', 'check', 'Shop',
           'upDateIt', 'findIt', 'deleteIt', 'createIt']


class Login:

    '''
    测试注释一可以写上此类的作用说明等
    例如此方法用来写登录
    '''

    def __init__(self):
        '''
        初始化你要的参数说明
        那么登录可能要用到
        用户名username
        密码password
        '''
        pass

    def check(self):
        '''
        协商你要实现的功能说明
        功能也有很多例如验证
        判断语句，验证码之类的
        '''
        pass


class Shop:

    '''
    商品类所包含的属性及方法
    update改/更新
    find查找
    delete删除
    create添加
    '''

    def __init__(self):
        '''
        初始化商品的价格、日期、分类等
        '''
        pass

    def upDateIt(self):
        '''
        用来更新商品信息
        '''
        pass

    def findIt(self):
        '''
        查找商品信息
        '''
        pass

    def deleteIt(self):
        '''
        删除过期下架商品信息
        '''
        pass

    def createIt(self):
        '''
        创建新商品及上架信息
        '''
        pass

if __name__ == "__main__":
    # 导入的需要自身的文件名，如本文件名python_doc
    import python_doc
    print (help(python_doc))
