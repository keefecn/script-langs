# Rules.make
# define some variable for makefile, common files
# support subdir
SUBDIR = src
LEX = flex
CC = gcc
CXX = g++
LD = g++ -g
LDLIB = -lpthread -lz
AR = ar

OBJS = $(TOPDIR)/$(SUBDIR)/ictclas.a
EXECS = ictclas 

CFLAGS = -c 
DEBUG = y
ifeq ($(DEBUG),y)
	CFLAGS += -g -Wall -D_ICT_DEBUG
else
	CFLAGS += -O2
endif
CFLAGS += -I$(INCDIR) 
