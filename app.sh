#!/usr/bin/env bash

function app_build {
    docker-compose build
}

function app_start {
    docker-compose up \
        --abort-on-container-exit \
        --remove-orphans
}

function app_stop {
    docker-compose down \
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

function start_app {
    if app_running -eq 1; then
        docker start python-app-container
    fi
}

function database_running {
    if [ $(docker inspect -f '{{.State.Running}}' python-app-database-container) ]; then
        return 0
    else
        return 1
    fi;
}

function start_database {
    if database_running -eq 1; then
        docker start python-app-database-container
    fi
}

function db_process {
    start_app
    start_database

    docker exec -i python-app-container sh -c "flask db $1"
}

case $1 in
    "init")
        app_build;;
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
