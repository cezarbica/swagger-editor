FROM registry.access.redhat.com/ubi8/ubi:8.1
ARG CONTAINER_USER=12345

RUN mkdir -p /run/nginx && yum install nginx -y

COPY nginx.conf /etc/nginx/

# copy swagger files to the `/js` folder
COPY ./index.html /usr/share/nginx/html/
ADD ./dist/*.js /usr/share/nginx/html/dist/
ADD ./dist/*.map /usr/share/nginx/html/dist/
ADD ./dist/*.css /usr/share/nginx/html/dist/
ADD ./dist/*.png /usr/share/nginx/html/dist/
ADD ./docker-run.sh /usr/share/nginx/


RUN echo ${CONTAINER_USER} && touch /run/nginx.pid && chown -R ${CONTAINER_USER} /usr/share/nginx/html/ /run/nginx.pid

USER ${CONTAINER_USER}

EXPOSE 8080

CMD ["sh", "/usr/share/nginx/docker-run.sh"]
