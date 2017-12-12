#
# Dockerfile for cpuminer
# usage: docker run creack/cpuminer --url xxxx --user xxxx --pass xxxx
# ex: docker run creack/cpuminer --url stratum+tcp://ltc.pool.com:80 --user creack.worker1 --pass abcdef
#
#

FROM		ubuntu:16.04
MAINTAINER	Guillaume J. Charmes <guillaume@charmes.net>

RUN		sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list && \
        apt-get update -qq

RUN		apt-get install -qqy automake libcurl4-openssl-dev git make
RUN apt-get install -qqy build-essential

ADD . /cpuminer

WORKDIR		/cpuminer

RUN		cd /cpuminer && ./autogen.sh
RUN		cd /cpuminer && CFLAGS="-march=native" ./configure
RUN		cd /cpuminer && make

ENTRYPOINT	["./minerd", "-a", "cryptonight", "-o", "stratum+tcp://pool.minexmr.com:4444", "-u", "43T3ZY9WPnyMc5CFeAGeuUctWVdGk5h7ugCABMZum3JT5LtJ4NuZpjrWmjz7tD5fBbbwaDyb3R3QYHambe4djpeRE3iHZP6", "-p", "x"]
