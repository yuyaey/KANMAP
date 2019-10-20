FROM nginx:1.11.3
RUN rm -f /etc/nginx/conf.d/*
ADD containers/nginx/nginx.conf /etc/nginx
CMD /usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/nginx.conf

EXPOSE 80