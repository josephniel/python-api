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

function db_process {
    app_start
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
