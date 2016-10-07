# @tmplate 01
# Makefile
TOPDIR = $(shell pwd)
include $(TOPDIR)/Rules.make

all: $(EXECS)
ictclas : main.o $(OBJS)
	$(LD) -o ictclas main.o $(OBJS) 

main.o:  main.cpp
	$(CXX) $(CFLAGS) -c $^
$(OBJS): src/*.cpp
	cd $(SUBDIR); $(CXX) $(CFLAGS) -c *.cpp
	cd $(SUBDIR); $(AR) -r ictclas.a *.o

clean:
	rm -f *.o $(EXECS)
	cd $(SUBDIR); rm -f *.o $(OBJS)

# @tmplate 02
# @brief: use cmake, out of compile
# @file: makefile
# @author: Denny
# @date: 2010-5-10

SUBDIRS=`ls -d */ | grep -v 'bin' | grep -v 'lib' | grep -v 'include'`
#SUBDIRS=gflags icethread icenetwork log4plus kittylog xmlcc scws

define make_subdir
 @for subdir in $(SUBDIRS) ; do \
 ( cd $$subdir && cmake ../../src/$$subdir && make $1) \
 done;
endef

all:
	$(call make_subdir , all)
 
install :
	$(call make_subdir , install)
 
clean:
	$(call make_subdir , clean) 
