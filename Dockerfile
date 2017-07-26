FROM ubuntu
MAINTAINER Ervin Ablaev ervindev@gmail.com

#set environment variables
ENV WEB_DIR='/usr/local/nginx/html'
ENV FLEX_HOME='/root/build/flex_sdk'

#get needed software
RUN apt-get update
RUN apt-get --assume-yes install build-essential libpcre3 libpcre3-dev libssl-dev
RUN apt-get --assume-yes install git
RUN apt-get --assume-yes install wget
RUN apt-get --assume-yes install default-jdk
RUN apt-get --assume-yes install ant

#install nginx and nginx-rtmp-module
RUN mkdir ~/build && cd ~/build \
	&& git clone git://github.com/arut/nginx-rtmp-module.git \
	&& wget http://nginx.org/download/nginx-1.12.0.tar.gz \
	&& tar xzf nginx-1.12.0.tar.gz \
	&& cd nginx-1.12.0 \
	&& ./configure --with-http_ssl_module --add-module=../nginx-rtmp-module \
	&& make \
	&& make install 

#copy necessary files to web directory	
COPY nginx.conf /usr/local/nginx/conf/nginx.conf
COPY index.html $WEB_DIR/index.html
COPY swfobject.js $WEB_DIR/swfobject.js

#install flex sdk 
RUN cd ~/build \
	&& wget http://apache.volia.net/flex/4.16.0/binaries/apache-flex-sdk-4.16.0-bin.tar.gz \
	&& tar -xzf apache-flex-sdk-4.16.0-bin.tar.gz \
	&& mv apache-flex-sdk-4.16.0-bin flex_sdk \
	&& cd flex_sdk \
	&& ant -f installer.xml -Dair.sdk.version=23 \ 
							-Djava.awt.headless=true \
							-Dinput.air.download=y \
							-Dinput.fontswf.download=y \
							-Dinput.flash.download=y 
#compile client app 
RUN cd ~/build \
	&& git clone https://github.com/ervindev/streamer-app.git \
	&& cd streamer-app/client/streamer/ant \
	&& ant -f build.xml \
	&& mv ../bin/main.swf $WEB_DIR/main.swf

EXPOSE 8080 1935
CMD ["/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]
