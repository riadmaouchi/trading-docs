FROM asciidoctor/docker-asciidoctor as builder

USER root

COPY ./docs /tmp/docs

RUN asciidoctor -a idprefix="" -a idseparator="-" -a icons=font -a experimental=true -a toc=left -a toclevels=3 -a hardbreaks=true -a sectanchors=true -a sectnums=true -a sectlinks=true -a linkcss=true -a stylesheet=fedora.css -a stylesdir=css '/tmp/docs/*.adoc'

FROM nginx:alpine

EXPOSE 80

HEALTHCHECK CMD curl --fail http://localhost:80 || exit 1

RUN rm -rf /tmp/DOCS-SERVER && mkdir -p /tmp/DOCS-SERVER && cd /tmp/DOCS-SERVER

COPY --from=builder /tmp/docs /tmp/DOCS-SERVER

RUN cp -r /tmp/DOCS-SERVER/* /usr/share/nginx/html

CMD ["nginx", "-g", "daemon off;"]