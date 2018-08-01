FROM python:3.6

ENV FLASK_APP "bootstrap:create_app('dev')"

COPY ./docker/api/setup.py ./app/api/setup.py
COPY ./api ./app/api

WORKDIR /app/api

RUN apt update && apt install -y postgresql-client
RUN pip3 install -e .

WORKDIR /app

COPY ./migrations ./app/migrations

CMD python3 api/__init__.py --env=${ENV}
