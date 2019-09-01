FROM    ubuntu
MAINTAINER      keefewu "wuqifu@gmail.com"

RUN     /bin/echo 'root:123456' |chpasswd
RUN     useradd keefe
RUN     /bin/echo 'keefe:123456' |chpasswd
RUN     /bin/echo -e "LANG=\"en_US.UTF-8\"" >/etc/default/local
EXPOSE  22
EXPOSE  80
CMD     /usr/sbin/sshd -D