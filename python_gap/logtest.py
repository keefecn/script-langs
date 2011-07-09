#! /usr/bin/python

import logging
import logging.config

logging.config.fileConfig("logging.conf")

#create logger
logger = logging.getLogger("root")

#"application" code
logger.debug("debug message")
logger.info("info message")
logger.warn("warn message")
logger.error("error message")
logger.critical("critical message")

logHello = logging.getLogger("hello")
logHello.info("Hello world!")

