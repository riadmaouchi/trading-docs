FROM nginx:alpine

USER root

EXPOSE 80

HEALTHCHECK CMD curl --fail http://localhost:80 || exit 1

COPY ./target/trading-docs.tar.gz /tmp/

RUN rm -rf /tmp/DOCS-SERVER && mkdir -p /tmp/DOCS-SERVER && cd /tmp/DOCS-SERVER && tar -xvf /tmp/trading-docs.tar.gz

RUN cp -r /tmp/DOCS-SERVER/* /usr/share/nginx/html

CMD ["nginx", "-g", "daemon off;"]