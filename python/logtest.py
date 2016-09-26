#! /usr/bin/python
# coding=utf-8
'''
@version: 0.1
@date: 2011-7-19
@author: denny
@see: http://www.red-dove.com/python_logging.html
'''
import logging
import logging.config

## method 1
# load configure
logging.config.fileConfig("logging.conf")
#create logger
logger = logging.getLogger("root")

url="http://www.cmuf.com/"
#"application" code
logger.debug(len(url))
logger.info("info message: %d", len(url))
logger.info("info message")
logger.warn("warn message")
logger.error("error message")
logger.critical("critical message")

logHello = logging.getLogger("hello")
logHello.info("Hello world!")

## mehtod 2
## setting.py
import logging
logging.basicConfig(
    level = logging.DEBUG,
    format = '%(asctime)s %(levelname)s %(module)s.%(funcName)s Line:%(lineno)d %(message)s',
    filename = 'filelog.log',
)
## usage:
import setting
logging.debug('This is a debug message')