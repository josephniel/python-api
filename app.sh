#!/usr/bin/env bash

function app_start {
    docker-compose up \
        --build \
        --abort-on-container-exit \
        --remove-orphans
}

function app_stop {
    docker-compose down \
        --rmi all \
        --remove-orphans
}

function app_check {
    app_test
    app_lint
}

function app_test { 
    echo "hello"
}

function app_lint {
    echo "hi"
}

function app_running {
    if [ $(docker inspect -f '{{.State.Running}}' python-app-container) ]; then
        return 0
    else
        return 1
    fi;
}

function database_running {
    if [ $(docker inspect -f '{{.State.Running}}' python-app-database-container) ]; then
        return 0
    else
        return 1
    fi;
}

function db_process {
    if app_running -eq 1; then
        docker start python-app-container
    fi;
    if database_running -eq 1; then
        docker start python-app-database-container
    fi;

    docker exec -i python-app-container sh -c "flask db $1"

    docker stop python-app-container
    docker stop python-app-database-container
}

case $1 in
    "start")
        app_start;;
    "stop")
        app_stop;;
    "check")
        app_check;;
    "test")
        app_test;;
    "lint")
        app_lint;;
    "db")
        db_process $2;;
esac
