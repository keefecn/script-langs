#!/usr/bin/python
# coding:utf8
# Filename: monitor.py
# Author: zhangshuo@staff.sina.com.cn
# Version: 2.2 2009-3-3
# Monitor client of CSF

import socket
import select
import threading
import os
import time
import sys
import signal
import re
import string
import tty
import termios
import locale
from pprint import *


if sys.version_info[:2] < (2, 4):
    def set(l):
        return dict(zip(l, [None, ] * len(l))).keys()


refresh_time_span = 1
cmd_stat_switch = 0
global_command = ""
is_color_on = 1

# name mapping
rname = {
    '0': 'starting',
    '1': 'waiting',
    '2': 'busy',
    '3': 'failed',
    '4': 'done',
}

#field_mask = [waiting, starting, failed, done]


#
# connection class
#
class monitor_socket:

    def connect_server(self, host, port):

        self.s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.s.connect((host, port))
        return self.s

    def close_server(self):

        try:
            self.s.close()

        except socket.error, e:
            print(e)
            return

    def send_data(self, command):

        try:
            command += "\n"
            self.s.sendall(command)
        except socket.error, e:
            print(e)
            return

    def read_data(self):

        try:
            recv = ""
            while(1):
                recv += self.s.recv(1024)
                if recv == "":
                    print "\nerror: EOF of socket."
                    self.close_server()
                    break
                if recv.endswith("\r\n") == True:
                    break

            return recv

        except socket.error, e:
            print e
            return


#
# process the commands and FD selection
#

class monitor_main:

    static_socket = 0

    def __init__(self):

        global global_command
        global cmd_stat_switch
        global is_color_on

        # caputure signal
        signal.signal(signal.SIGINT, self.myhandle)

        # get opt
        host = ""
        port = ""

        try:
            i = 0
            for option in sys.argv:
                i += 1
                if i == 1:
                    continue

                if option[0] == "-":
                    if option[1] == "b":
                        is_color_on = 0
                    elif option[1] == "h":
                        self.show_help_message()
                        sys.exit()
                else:
                    hp_temp = option.split(":")
                    if len(hp_temp) >= 2:
                        host = hp_temp[0]
                        port = hp_temp[1]
                    else:
                        host = option

            print host

            if host == "":
                host = "localhost"

            if port == "":
                port = "22222"

            self.my_socket = monitor_socket()
            self.socket_fd = self.my_socket.connect_server(
                host, string.atoi(port, 0))

            monitor_main.static_socket = self.my_socket

        except Exception, e:
            print "Syntax Error.", e, "\n"
            self.show_help_message()
            sys.exit()

        # select the ready FD
        is_readable = [self.socket_fd, sys.stdin]
        is_writable = []
        is_error = []

        command = ""
        self.show_prompt = 0
        self.history_data = {}

        j = 3
        command_history = []
        while 1:

            try:
                if self.show_prompt == 1 and cmd_stat_switch == 0:
                    sys.stdout.write(">>> ")
                    sys.stdout.flush()

                r, w, e = select.select(is_readable, is_writable, is_error)
                if sys.stdin in r:
                    self.show_prompt = 0
                    command = ""
                    command = raw_input()
                    command = command.strip()
                    global_command = command

                    if cmd_stat_switch == 1:
                        cmd_stat_switch = 0

                    self.cmd_analysis(command)

                elif self.socket_fd in r:
                    self.show_prompt = 1
                    data = self.my_socket.read_data()
                    self.display(command, data)

            except Exception, e:
                import traceback
                traceback.print_exc()
                print "\nstandard input or socket error."
                self.cmd_analysis("quit")

    def cmd_analysis(self, command):

        global refresh_time_span
        global cmd_stat_switch
        command = re.sub("\s+", " ", command)

        # local command processing
        if command == "" != -1:
            self.show_prompt = 1
            return

        if command.find("stat") != -1:

            try:
                # filtrate bad command
                corrent_cmd = ["-n", "-e"]

                options = command.split(" ")
                for option in options:
                    if option.startswith("-"):
                        if option in corrent_cmd:
                            break
                        else:
                            print "bad parameter. '%s' not support.\n" \
                                "please refer to help by typing 'help'.\n" % (
                                    option)
                            self.show_prompt = 1
                            return

                # set the refresh_time_span
                time_option = command.find("-n")
                if time_option != -1:
                    time_span = command[time_option:]
                    time_span = time_span.split(" ")
                    refresh_time_span = string.atoi(time_span[1], 0)

            except Exception, e:
                print "missing parameter.\n" \
                    "please refer to help by typing 'help'.\n"
                self.show_prompt = 1
                return

            # attach the stat to a thread
            cmd_stat_switch = 1
            cmd_stat().start()
            return

        # we use local help instead of server help
        # but simple telnet can use server side help
        if command.find("help") != -1:
            self.show_help_message()
            self.show_prompt = 1
            return

        if command.find("quit") != -1 or command.find("q") != -1:

            print "closing ..."
            # close the tread switch
            cmd_stat_switch = 0
            # wait for other threads
            if cmd_stat().isAlive == True:
                cmd_stat().join()

            print "exited."
            self.my_socket.close_server()
            sys.exit()

        # send command to remote server
        self.my_socket.send_data(command)

    def print_stat(self, dest_str):

        # print dest_str
        # print '*' * 80

        # transform 'MNT_GROUP_STAT'
        dest_str = str2ptg(dest_str)

        # print dest_str
        # print '*' * 80

        # parse the string
        dest_str = dest_str.split("|")[:-1]

        # module types array
        module_types = []
        new_module_types = []

        for each_class in dest_str:
            each_class = each_class.split(",")[2]
            module_types.append(each_class)

        module_types.sort()

        history = ""
        for each_type in module_types:
            if each_type != history:
                new_module_types.append(each_type)
            history = each_type

        # print new_module_types

        for exclusive_type in new_module_types:
            print "[%s]" % exclusive_type
            value_of_type = []
            for item in dest_str:
                if exclusive_type in item:
                    value_of_type.append(item)
            # print value_of_type
            value_of_type.sort()

            self.print_stat_sub_proc(value_of_type)

        print "-" * 80

    def print_stat_sub_proc(self, dest_str):

        m = 0
        n = 0
        var_value = []
        temp_string = ""
        temp_word1 = ""
        for arr in dest_str:
            word = arr.split(",")

            #####################################################
            # add digital group symbol in the digital number.
            # 1 gourp every 1000 times
            #####################################################

            # digital group symbol
            if (word[1].isdigit()):

                digital_str_array = []
                digital_str = range(len(word[1]), -1, -3)
                digital_str_split = zip(digital_str, digital_str[1:] + [0, ])
                digital_str_split.reverse()

                # print digital_str_split

                for x, y in digital_str_split:
                    temp = word[1][y: x]
                    if temp != "":
                        digital_str_array.append(temp)

                # print digital_str_array
                word[1] = ','.join(digital_str_array)

            #####################################################
            # add digital group symbol in the digital number end
            #####################################################

            temp_word1 = word[1]

            # check the differece
            if self.history_data.has_key(word[0] + word[2]):

                if word[1] != self.history_data[word[0] + word[2]]:
                    word[1] = '\033' + word[1]

            # save the current data to history dict
            self.history_data[word[0] + word[2]] = temp_word1

            m += 1
            var_value.append(word[1])
            temp_string += '%-19s' % (word[0][0:19])

            if m % 4 == 0 or m == len(dest_str):
                temp_string += "\n"
                for each_value in var_value:
                    n += 1
                    if each_value[0] == '\033':
                        each_value = each_value[1:]
                        color_string = '%-19s' % (locale.format('%s',
                                                                each_value, True))
                        color_string = colored(
                            color_string, 'red', attrs=['bold'])
                        temp_string += color_string
                    else:
                        temp_string += '%-19s' % (locale.format('%s',
                                                                each_value, True))

                    # print "len=",len(dest_str),"n=",n
                    if n % 4 == 0 or n == len(dest_str):
                        temp_string += "\n"

                # print "===="

                var_value = []
                if m == len(dest_str):
                    temp_string += "\n"
        # print "===="
        print temp_string,

    def print_list(self, dest_str):

        # parse the string
        dest_str = dest_str.split("|")[:-1]
        temp_arr = []
        temp_string = ""

        for arr in dest_str:
            temp = []
            word_arr = arr.split(",")
            temp.append(word_arr[0])
            temp.append(word_arr[1])
            temp_arr.append(temp)

        temp_arr.sort()

        temp_string += "\n"
        for item in temp_arr:
            temp_string += '%20s  ->  %-20s\n' % (item[0], item[1])
        temp_string += "\n"

        print temp_string,

    def print_default(self, dest_str):

        print dest_str

    def display(self, command, data):
        global cmd_stat_switch

        if command.find("stat") != -1:
            if data == "\r\n\r\n":
                cmd_stat_switch = 0
                print "stat: no data matched.\n"
            else:
                self.print_stat(data)

        elif command.find("list") != -1:
            self.print_list(data)
        else:
            self.print_default(data)

    def myhandle(self, a, b):

        #global read_display_switch
        global cmd_stat_switch
        cmd_stat_switch = 0

    def show_help_message(self):
        print "Usage: monitor [host[:port]] [options]\n" \
            "       host: the monitor server IP. the default host is localhost.\n" \
            "       port: the monitor server port. the default port is 22222.\n" \
            "options: \n" \
            "       -b: (back & white)disable the color support.\n" \
            "       -h: show this help.\n\n" \
            "Internal Commands: \n\n" \
            "  stat         Watch the registered variables. Type CTRL+C to quit.\n\n" \
            "       stat item1,...,itemN [-e item1,...,itemN] [-n time_interval]\n" \
            "       parameter: item1,...,itemN. The items you want to monitor.\n" \
            "       option -e: item1,...,itemN. The items you want not to monitor.\n" \
            "       option -n: time_interval. Data refresh time interval.(in second)\n\n" \
            "  list         List the items registered.\n" \
            "  help         Show this help in runtime.\n" \
            "  stop         Stop the remote monitor service. And you CAN NOT connect again!\n" \
            "  quit         Quit this client.\n"


#
# command "stat"
# this is a thread used to display the stat info every 1 second
# the thread automatically refresh the screen and print latest values
#
class cmd_stat(threading.Thread):

    def run(self):
        global global_command
        global cmd_stat_switch
        global refresh_time_span

        # clone a mirror of current command
        stat_command = global_command

        while 1:

            monitor_main.static_socket.send_data(stat_command)
            time.sleep(refresh_time_span)
            # when the switch turns off by other thread, this one returns
            # it is probably switched off by pressing ENTER when
            # "cmd_stat_switch == 1"
            if cmd_stat_switch == 0:
                return


# Copyright (C) 2008 Konstantin Lepa <konstantin.lepa@gmail.com>.
#
# This file is part of termcolor.
#
# termcolor is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by the Free
# Software Foundation; either version 3, or (at your option) any later
# version.
#
# termcolor is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
# more details.
#
# You should have received a copy of the GNU General Public License
# along with termcolor.  If not, see <http://www.gnu.org/licenses/>.

__ALL__ = ['colored']


attributes = dict(
    zip([
        'bold',
        'dark',
        '',
        'underline',
        'blink',
        '',
        'reverse',
        'concealed'
    ],
        range(1, 9)
    )
)
del attributes['']


highlights = dict(
    zip([
        'on_grey',
        'on_red',
        'on_green',
        'on_yellow',
        'on_blue',
        'on_magenta',
        'on_cyan',
        'on_white'
    ],
        range(40, 48)
    )
)


colors = dict(
    zip([
        'grey',
        'red',
        'green',
        'yellow',
        'blue',
        'magenta',
        'cyan',
        'white',
    ],
        range(30, 38)
    )
)


def colored(text, color=None, on_color=None, attrs=None):

    global is_color_on

    if is_color_on == 0:
        return text

    if os.getenv('ANSI_COLORS_DISABLED') is None:
        fmt_str = '\033[1;%dm%s'
        if color is not None:
            text = fmt_str % (colors[color], text)

        if on_color is not None:
            text = fmt_str % (highlights[on_color], text)

        if attrs is not None:
            for attr in attrs:
                text = fmt_str % (attributes[attr], text)

        reset = '\033[1;m'
        text += reset

    return text


###########################################################
# transform xxx||xxx||vvv|vvv| to fraction form
###########################################################


def str2ptg(str):

    cnt = str.split('|')
    cnt_m = []
    oth = []

    for item in cnt:
        if item[-2:] == "##":
            cnt_m.append(item[:-2])
        else:
            oth.append(item)

    if len(cnt_m) == 0:
        return '|'.join(oth)

    cnt = cnt_m

    cnt = [i.split(',', 1) for i in cnt]

    grs = set([i[1] for i in cnt])

    grs = [gr.split(',', 1) + [len([i for i in cnt if i[1] == gr]), ]
           for gr in grs]

    gs = set([g for r, g, n in grs])

    gs = zip(gs, [sum([n for r, g, n in grs if g == G]) for G in gs])

    modules = []
    for item in gs:
        modules.append(item[0])

    # print "====",modules,"========"

    gs = dict(gs)

    #grs.sort(key = lambda x: ','.join([x[1],x[0]]))
    grs.sort(lambda x, y: cmp(','.join([x[1], x[0]]), ','.join([y[1], y[0]])))

    # print grs

    # only show 'busy' field
    grs_filtered = []
    for item in grs:
        if item[0] == '2':
            grs_filtered.append(item)

    grs = grs_filtered

    # print grs

    for item in modules:
        item_found = 0
        for item_grs in grs:
            # print "'%s' - '%s'" % (item_grs[1], item)
            if item_grs[1] == item:
                item_found = 1
                break

        # print "--->", item_found, item

        if item_found == 0:
            grs_item = []
            grs_item.append("2")
            grs_item.append(item)
            grs_item.append(0)
            grs.append(grs_item)

    if len(grs) <= 0:
        if len(oth) != 0:
            return '|'.join(oth)
        else:
            return ""

    # print grs

    grs = ['%s/total,%d/%d,%s' % (rname[r], n, gs[g], g) for r, g, n in grs]

    if len(oth) == 0:
        return '|'.join(grs) + '|'
    else:
        return '|'.join(grs) + '|' + '|'.join(oth)


###########################################################

if __name__ == "__main__":
    locale.setlocale(locale.LC_ALL, "")

    my_monitor = monitor_main()
