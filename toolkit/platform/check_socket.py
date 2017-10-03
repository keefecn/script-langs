# -*- coding: utf-8 -*-
'''
@desc: 
@author: Denny
@date: 2017/10/2
@note:
'''

import socket

def print_socket():
    print('socket.SO_RCVBUF = %d' %socket.SO_RCVBUF)
    print('socket.SO_RCVLOWAT = %d' %socket.SO_RCVLOWAT)
    print('socket.SO_RCVTIMEO = %d' %socket.SO_RCVTIMEO)
    print('socket.SO_SNDBUF = %d' %socket.SO_SNDBUF)
    print('socket.SO_SNDLOWAT = %d' %socket.SO_SNDLOWAT)
    print('socket.SO_SNDTIMEO = %d' %socket.SO_SNDTIMEO)
    print('socket.SO_LINGER = %d' %socket.SO_LINGER)
    print('socket.SO_KEEPALIVE = %d' %socket.SO_KEEPALIVE)
    print('socket.SO_ACCEPTCONN = %d' %socket.SO_ACCEPTCONN)

    print('\nsocket.TCP_MAXSEG = %d' %socket.TCP_MAXSEG)
    print('socket.TCP_NODELAY = %d' %socket.TCP_NODELAY)
    print('socket.SOMAXCONN = %d' %socket.SOMAXCONN)
    

if __name__ == "__main__":
    print_socket()
