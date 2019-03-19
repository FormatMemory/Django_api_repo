FROM python:3.7-alpine
MAINTAINER FormatMemory <davidthinkleding@gmail.com>

#ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt
# RUN apk add --update --no-cache mysql-client
RUN apk add --update --no-cache --virtual .tmp-build-deps \
        gcc libc-dev linux-headers python3-dev libmysqlclient-dev
RUN apk del .tmp-build-deps
RUN pip install -r /requirements.txt

RUN mkdir /app
WORKDIR /app
COPY ./app /app

RUN adduser -D user
USER user

