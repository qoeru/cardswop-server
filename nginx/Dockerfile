FROM nginx as nginx

RUN rm /etc/nginx/conf.d/default.conf

COPY nginx.conf /etc/nginx/nginx.conf

STOPSIGNAL SIGTERM
CMD ["nginx", "-g", "daemon off;"]