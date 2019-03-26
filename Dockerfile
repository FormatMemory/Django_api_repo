FROM python:3.7-alpine
MAINTAINER FormatMemory <davidthinkleding@gmail.com>

ENV PYTHONUNBUFFERED 1

RUN apk update
RUN apk upgrade
RUN apk add --update --no-cache --virtual .tmp-build-deps \
        git \
        gcc \
        libc-dev \
        libffi-dev \
        linux-headers \
        build-base \
        py-mysqldb \
        mariadb-dev \
        mariadb-client \
        musl-dev \
        zlib \
        zlib-dev
        
RUN apk add ca-certificates && update-ca-certificates
RUN apk add --update --no-cache tzdata jpeg-dev
# Change TimeZone
# ENV TZ=America/Los_Angeles
ENV TZ=${TIME_ZONE}
# RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
COPY ./requirements.txt /requirements.txt
RUN pip install --upgrade setuptools
RUN pip install -r /requirements.txt
RUN rm -rf .cache/pip
RUN apk del .tmp-build-deps

RUN mkdir /app
WORKDIR /app
COPY ./app /app
COPY ./mysql_data/docker-entrypoint-initdb.d /docker-entrypoint-initdb.d
COPY ./mysql_data/mysql /var/lib/mysql

RUN mkdir -p /vol/web/media
RUN mkdir -p /vol/web/static

RUN adduser -D user
RUN chown -R user:user /vol/
RUN chmod -R 755 /vol/web
USER user

EXPOSE 8000
#CMD ["python", "manage.py", "migrate"]
