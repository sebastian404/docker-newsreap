FROM alpine:3.11

MAINTAINER  Sebastian Robinson sebastian@podtwo.com

RUN \
 echo "**** install packages ****" && \
 apk upgrade && \
 apk add --no-cache build-base automake autoconf libtool findutils jq git curl wget python2 python2-dev py-pip bash p7zip libffi libxml2 libxslt libffi-dev openssl zlib libxml2-dev libxslt-dev openssl-dev zlib-dev mysql-dev

RUN \
 echo "**** python setup ****" && \
 pip install --upgrade pip; pip install wheel coveralls mysqlclient

RUN \
 echo "**** install uudeview ****" && \
 cd /tmp/ && \
 wget http://www.fpx.de/fp/Software/UUDeview/download/uudeview-0.5.20.tar.gz && \
 tar zxvf uudeview-0.5.20.tar.gz && \
 cd uudeview-0.5.20 && \
 ./configure && \
 make && \
 make install

RUN \
 echo "**** install newsreap ****" && \
 cd /tmp/ && \
 git clone https://github.com/sebastian404/newsreap.git && \
 cd newsreap/ && \
 pip install -r requirements.txt && \
 ./setup.py install

RUN \	
 echo "**** cleanup ****" && \
 cd /tmp/ && \
 rm -rf /tmp/*

CMD tail -f /dev/null
