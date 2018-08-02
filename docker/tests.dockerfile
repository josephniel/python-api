FROM python:3.6

ENV FLASK_APP "bootstrap:create_app('dev')"

WORKDIR /app

COPY ./api ./api
COPY ./setup.py ./api/setup.py
COPY ./migrations ./migrations
COPY ./tests ./tests

WORKDIR /app/api

RUN apt update && apt install -y postgresql-client
RUN pip3 install -e .[test]

WORKDIR /app

CMD pytest tests
