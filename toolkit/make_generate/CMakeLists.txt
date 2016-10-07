project( CACHE )
cmake_minimum_required( VERSION 2.6 )

set( CMAKE_CXX_FLAGS "-O2 -Wall -g" )
add_definitions( -DUSE_NET_BYTE )

set( PROCESS_NAME cache)
aux_source_directory( . NEWSMIDLAYER_SRC )
add_executable( ${PROCESS_NAME} ${NEWSMIDLAYER_SRC} )

target_link_libraries( ${PROCESS_NAME} pthread )

#set (CMAKE_INCLUDE_PATH ../../commonlib/include )
#set (CMAKE_LIBERARY_PATH ../../commonlib/lib )

# set module relational
set( CMAKE_MODULE_PATH modules )
set( COMMON_INC_DIR ../../commonlib/include )
IF ( CMAKE_SIZEOF_VOID_P  EQUAL 8 )
        set( COMMON_LIB_DIR ../../commonlib/lib64 )
ELSE()
        set( COMMON_LIB_DIR ../../commonlib/lib )
ENDIF()

find_package( libicethread  REQUIRED )
find_package( libicenetwork REQUIRED )
find_package( libgflags     REQUIRED )
find_package( liblog4cplus  REQUIRED )
find_package( libkittylog   REQUIRED )
mark_as_advanced( 
    ICETHREAD_LIB_INC
    ICETHREAD_LIB_DIR
    ICENETWORK_LIB_INC
    ICENETWORK_LIB_DIR
    GFLAGS_LIB_INC
    GFLAGS_LIB_DIR
    KITTYLOG_LIB_INC
    KITTYLOG_LIB_DIR
    LOG4CPLUS_LIB_INC
    LOG4CPLUS_LIB_DIR
    )
message( STATUS ${ICETHREAD_LIB_DIR} )
message( STATUS ${ICETHREAD_INC_DIR} )
message( STATUS ${ICENETWORK_LIB_DIR} )
message( STATUS ${ICENETWORK_INC_DIR} )

IF ( ICETHREAD_LIB_DIR AND ICETHREAD_INC_DIR )
    message( STATUS "ice thread.............." )
    target_link_libraries( ${PROCESS_NAME} ${ICETHREAD_LIB_DIR} )
ENDIF ( ICETHREAD_LIB_DIR AND ICETHREAD_INC_DIR )

IF ( ICENETWORK_LIB_DIR AND ICENETWORK_INC_DIR )
    message( STATUS "ice network.............." )
    target_link_libraries( ${PROCESS_NAME} ${ICENETWORK_LIB_DIR} )
    include_directories( ${ICETHREAD_INC_DIR} )
ENDIF ( ICENETWORK_LIB_DIR AND ICENETWORK_INC_DIR )

IF ( GFLAGS_LIB_DIR AND GFLAGS_INC_DIR )
    message( STATUS "gflags.............." )
    target_link_libraries( ${PROCESS_NAME} ${GFLAGS_LIB_DIR} )
ENDIF ( GFLAGS_LIB_DIR AND GFLAGS_INC_DIR )

IF ( LOG4CPLUS_LIB_DIR AND LOG4CPLUS_INC_DIR )
    message( STATUS "log4cplus.............." )
    target_link_libraries( ${PROCESS_NAME} ${LOG4CPLUS_LIB_DIR} )
ENDIF ( LOG4CPLUS_LIB_DIR AND LOG4CPLUS_INC_DIR )

IF ( KITTYLOG_LIB_DIR AND KITTYLOG_INC_DIR )
    message( STATUS "kitty log.............." )
    target_link_libraries( ${PROCESS_NAME} ${KITTYLOG_LIB_DIR} )
    #include_directories( ${LOG4CPLUS_LIB_DIR} )
ENDIF ( KITTYLOG_LIB_DIR AND KITTYLOG_INC_DIR )
