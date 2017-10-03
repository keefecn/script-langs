#!/usr/local/bin/python
# -*- coding: utf-8 -*-
'''
@version: 0.1
@author: Denny
@date: 2011-7-19
@note: 
Object: loggers, handlers, formatters
logger: root,...
handler: StreamHandler FileHandler RotatingFileHandler TimedRotatingFileHandler 
    SocketHandler DatagramHandler SMTPHandler
format: %(xxx)s--name,levelno,levelname,pathname,filename,module,funcName,asctime,threadName,message
       %(xxx)d--lineno,created,msecs,thread,process 
       default: logging._defaultFormatter=%(message)s    
Level: DEBUG < INFO < WARNING < ERROR < CRITICAL, Default INFO+
@warning: 
1. only use once logging.getLogger
2. parent/son logger only by name
'''
import logging.config


def get_logger_from_config():
    # method 1:  use config
    # load logging module, and create logger, path '/' in linux, if '\' will error    
    logging.config.fileConfig("log/logging.conf")
    return logging.getLogger("root")

def create_basic_log():
    # method 2: use logging.basicConfig
    logging.basicConfig(
        level=logging.WARNING,
        format='%(asctime)s %(levelname)s %(module)s.%(funcName)s Line:%(lineno)d %(message)s',
        # filename = 'filelog.log'
    )   
    
def create_log(filename='create.log'):
    # method 3: use logging.getLogger
    l_logger = logging.getLogger(filename)
    l_logger.setLevel(logging.ERROR)
    logformatter = logging.Formatter('%(asctime)s (%(levelname)s) %(module)s.%(funcName)s line:%(lineno)d %(message)s')
    # set file_handler
    file_handler = logging.FileHandler(filename)
    file_handler.setFormatter(logformatter)
    l_logger.addHandler(file_handler)
    # set StreamHandler, console output wrong logformatter
    console_handler = logging.StreamHandler()
    # console_handler.setFormatter(logformatter)
    l_logger.addHandler(console_handler)    
    return l_logger
    
def test_logging_default():
    # level: DEBUG < INFO < WARINGING < ERROR < critical, default INFO+
    create_basic_log()
    logging.debug('logging.debug')
    logging.info('logging.info')
    logging.warn('logging.warn')
    logging.error('logging.error')    
    logging.critical('logging.critical')
    
def test_logger(l_logger):    
    l_logger.debug('create_log.debug')
    l_logger.info('create_log.info')
    l_logger.warn('create_log.warn')
    l_logger.error('create_log.error')    
    l_logger.critical('create_log.critical')
     
################################################    
# logging.getLogger only once        
logging.config.fileConfig("log/logging.conf")
logger = logging.getLogger("root")
# logger = get_logger_from_config()
# logger = create_log()

################################################        
if __name__ == "__main__":
    pass
    # test_logging_default()
    c_logger = create_log()
    # c_logger = get_logger_from_config()
    test_logger(c_logger)
