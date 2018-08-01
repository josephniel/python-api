FROM python:3.6

ENV FLASK_APP "bootstrap:create_app('dev')"

COPY ./docker/app/setup.py ./app/setup.py
COPY ./app ./app

WORKDIR ./app

RUN apt update && apt install -y postgresql-client
RUN pip3 install -e .

CMD python3 __init__.py --env=${ENV}
