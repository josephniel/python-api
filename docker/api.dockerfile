FROM python:3.6

ENV FLASK_APP "bootstrap:create_app('dev')"

WORKDIR /app

COPY ./api ./api
COPY ./setup.py ./api/setup.py
COPY ./migrations ./migrations

WORKDIR /app/api

RUN apt update && apt install -y postgresql-client
RUN pip3 install -e .

WORKDIR /app

CMD python3 api/__init__.py --env=${ENV}
