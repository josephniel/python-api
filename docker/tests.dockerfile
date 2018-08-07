FROM python:3.6

ENV FLASK_APP "bootstrap:create_app('dev')"

WORKDIR /app

COPY ./api ./api
COPY ./migrations ./migrations
COPY ./tests ./tests
COPY ./docker/setup.py ./api/setup.py
COPY ./docker/tests.sh ./tests.sh
COPY ./docker/mypy.ini ./api/mypy.ini
COPY ./docker/mypy.ini ./tests/mypy.ini

WORKDIR /app/api

RUN apt update && apt install -y postgresql-client
RUN pip3 install -e .[test]

WORKDIR /app

ENTRYPOINT [ "sh" ]
