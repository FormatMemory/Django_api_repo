FROM python:3.7-alpine
MAINTAINER FormatMemory <davidthinkleding@gmail.com>

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt
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
        tzdata
RUN apk add ca-certificates && update-ca-certificates
# Change TimeZone
# RUN apk add --update tzdata
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
# Clean APK cache
RUN pip install --upgrade setuptools
RUN pip install -r /requirements.txt
RUN rm -rf .cache/pip
# RUN rm -rf /var/cache/apk/*
RUN apk del .tmp-build-deps
# RUN echo ${TIME_ZONE} > /etc/timezone
# RUN dpkg-reconfigure -f noninteractive tzdata

RUN mkdir /app
WORKDIR /app
COPY ./app /app
COPY ./mysql_data/docker-entrypoint-initdb.d /docker-entrypoint-initdb.d
COPY ./mysql_data/mysql /var/lib/mysql

RUN adduser -D user
USER user

EXPOSE 8000
#CMD ["python", "manage.py", "migrate"]
