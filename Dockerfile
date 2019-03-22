FROM python:3.7-alpine
MAINTAINER FormatMemory <davidthinkleding@gmail.com>

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt
RUN apk add --update --no-cache --virtual .tmp-build-deps \
        git \
        gcc \
        libc-dev \
        libffi-dev \
        linux-headers \
        build-base \
        py-mysqldb \
        mariadb-dev \
        mariadb-client
RUN pip install --upgrade setuptools
RUN pip install -r /requirements.txt
RUN rm -rf .cache/pip
RUN apk del .tmp-build-deps

RUN mkdir /app
WORKDIR /app
COPY ./app /app
COPY ./data ./data

RUN adduser -D user
USER user

EXPOSE 8000
#CMD ["python", "manage.py", "migrate"]
