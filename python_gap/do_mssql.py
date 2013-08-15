#!/usr/bin/python
import pymssql
import os, sys
import time
str=time.strftime('%Y%m%d', time.gmtime())
mssql_con = pymssql.connect(host='211.151.48.200', user='Wxtlsl', password='ANtgxoONQRXk5su', database='TXDB');
mssql_cur = mssql_con.cursor()
mssql_cur.execute("select F_ID, F_DATE,  F_ZP_DATE,  F_ZHJYRQ, F_UPDATE_TIME from dbo.T_STOCK_HALT where F_UPDATE_TIME <='%s';" %str)
name="./tuishi/tuishi"+str+".xml"
fp=open(name, "w")
fp.write('F_ID |F_DATE |F_ZP_DATE |F_ZHJYRQ |F_UPDATE_TIME|\n');
for d in mssql_cur.fetchall():
    id= '%s' %d[0]
    id=id.strip();
    fdate='%d' %d[1]
    fzpdate='%d' %d[2]
    fzhjyrq='%s' %d[3]
    fupdate='%s' %d[4]
    fp.write(id+'|'+fdate+'|'+fzpdate+'|'+fzhjyrq+'|'+fupdate+'|\n')
fp.close()
mssql_con.close()
