FROM ubuntu
MAINTAINER Ervin Ablaev ervindev@gmail.com

RUN apt-get update
RUN apt-get --assume-yes install build-essential libpcre3 libpcre3-dev libssl-dev
RUN apt-get --assume-yes install git
RUN apt-get --assume-yes install wget
RUN mkdir ~/build && cd ~/build \
	&& git clone git://github.com/arut/nginx-rtmp-module.git \
	&& wget http://nginx.org/download/nginx-1.12.0.tar.gz \
	&& tar xzf nginx-1.12.0.tar.gz \
	&& cd nginx-1.12.0 \
	&& ./configure --with-http_ssl_module --add-module=../nginx-rtmp-module \
	&& make \
	&& make install 

COPY nginx.conf /usr/local/nginx/conf/nginx.conf
COPY index.html /usr/local/nginx/html/index.html
COPY main.swf /usr/local/nginx/html/main.swf
COPY swfobject.js /usr/local/nginx/html/swfobject.js

EXPOSE 8080 1935
CMD ["/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]
