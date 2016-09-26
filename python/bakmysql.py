#! /usr/bin/python
# coding=utf-8
'''
@version: $Id$
@author: Denny wuqifu@gmail.com
@date: 2011-5-19
@seer: http://mysql-python.sourceforge.net/
'''

import MySQLdb

# only function,not use class
def backupSQL(start, end):
    conn1 = MySQLdb.connect("192.168.114.6", "user", "pwd", "db")
    conn2 = MySQLdb.connect("192.168.114.146", "user", "pwd", "db")
    table1 = 'news'
    table2 = 'news'

    # process table news
    for id in range(start, end):
        try:
            # get data from news
            #sql = 'SELECT * FROM ' + table1 + ' WHERE id=' + str(id)
            sql = 'SELECT id, name,sid,url,pubtime,author,abstract ,source, type,ctime,img,maintype,topic FROM ' + table1 + ' WHERE id=' + str(id)
            #sql = 'SELECT id, name FROM' + table1 +' WHERE id=' + str(id)
            cur = conn1.cursor()
            cur.execute(sql)
            row = cur.fetchone()
            rownum = len(row);
            #print 'rownum', rownum
            print 'id:', id
        except Exception, e:
            print 'db select error ', e
            continue

        try:
            # insert data to newsbak
            cur2 = conn2.cursor()
            param = []
            sql = 'INSERT INTO ' + table2 + ' (id, name,sid,url,pubtime,author,abstract ,source, type,ctime,img,maintype,topic)  VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)'
            for result in row:
                #if result!= None:
                param.append(result)

            cur2.execute(sql, param)
            cur2.close()
            cur.close()
        except Exception, e:
            print 'db insert error ', e
            pass

    conn2.commit()
    conn1.close()
    conn2.close()


# test from here
backupSQL(12671892, 12672095);
