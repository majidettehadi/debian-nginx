FROM majid7221/debian:stretch

RUN set -ex \
	&& apt-key adv --no-tty --keyserver ha.pool.sks-keyservers.net --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62 \
	&& echo "deb https://nginx.org/packages/mainline/debian/ stretch nginx" > /etc/apt/sources.list.d/nginx.list \
	&& apt-get update \
	&& apt-get install --no-install-recommends -y \
	    nginx \
	    nginx-module-xslt \
	    nginx-module-geoip \
	    nginx-module-image-filter \
	    nginx-module-njs \
	    gettext-base \
	&& rm -rf /var/lib/{apt,dpkg,cache,log}/ /tmp/* /var/tmp/* \
	&& ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80 443

STOPSIGNAL SIGTERM

CMD ["nginx", "-g", "daemon off;"]