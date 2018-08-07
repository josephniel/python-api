#!/usr/bin/env bash

APP_CONTAINER_NAME=python-app-container
APP_DB_CONTAINER_NAME=python-app-database-container

TEST_APP_CONTAINER_NAME=python-app-tests-container
TEST_APP_DB_CONTAINER_NAME=python-app-tests-database-container

function app_running {
    if [ $(docker inspect -f '{{.State.Running}}' $APP_CONTAINER_NAME) ]; then
        return 0
    else
        return 1
    fi;
}

function db_running {
    if [ $(docker inspect -f '{{.State.Running}}' $APP_DB_CONTAINER_NAME) ]; then
        return 0
    else
        return 1
    fi;
}

function test_app_running {
    if [ $(docker inspect -f '{{.State.Running}}' $TEST_APP_CONTAINER_NAME) ]; then
        return 0
    else
        return 1
    fi;
}

function test_db_running {
    if [ $(docker inspect -f '{{.State.Running}}' $TEST_APP_DB_CONTAINER_NAME) ]; then
        return 0
    else
        return 1
    fi;
}

function app_existing {
    if $(docker ps -a -q -f name=^/$APP_CONTAINER_NAME$); then
        return 0
    else
        return 1
    fi;
}

function db_existing {
    if $(docker ps -a -q -f name=^/$APP_DB_CONTAINER_NAME$); then
        return 0
    else
        return 1
    fi;
}

function test_app_existing {
    if $(docker ps -a -q -f name=^/$TEST_APP_CONTAINER_NAME$); then
        return 0
    else
        return 1
    fi;
}

function test_db_existing {
    if $(docker ps -a -q -f name=^/$TEST_APP_DB_CONTAINER_NAME$); then
        return 0
    else
        return 1
    fi;
}

function app_build {
    docker-compose -f ./docker-compose.yml build
}

function test_build {
    docker-compose -f ./docker-compose.test.yml build app
}

function app_start {
    if app_existing -eq 1; then
        app_build
    fi

    docker-compose -f ./docker-compose.yml up \
        --abort-on-container-exit \
        --remove-orphans
}

function test_start {
    if test_app_existing -eq 1; then
        test_build
    fi

    docker-compose -f ./docker-compose.test.yml up \
        --abort-on-container-exit \
        --remove-orphans \
        app

    test_rm
}

function app_rm {
    if app_existing -eq 0; then
        if app_running -eq 0; then
            docker stop $APP_CONTAINER_NAME | echo "Stopping $(cat)"
        fi
        docker rm $APP_CONTAINER_NAME | echo "Removing $(cat)"
    fi
    if db_existing -eq 0; then
        if db_running -eq 0; then
            docker stop $APP_DB_CONTAINER_NAME | echo "Stopping $(cat)"
        fi
        docker rm $APP_DB_CONTAINER_NAME | echo "Removing $(cat)"
    fi
}

function test_rm {
    if test_app_existing -eq 0; then
        if test_app_running -eq 0; then
            docker stop $TEST_APP_CONTAINER_NAME | echo "Stopping $(cat)"
        fi
        docker rm $TEST_APP_CONTAINER_NAME | echo "Removing $(cat)"
    fi
    if test_db_existing -eq 0; then
        if test_db_running -eq 0; then
            docker stop $TEST_APP_DB_CONTAINER_NAME | echo "Stopping $(cat)"
        fi
        docker rm $TEST_APP_DB_CONTAINER_NAME | echo "Removing $(cat)"
    fi
}

function database_running {
    if [ $(docker inspect -f '{{.State.Running}}' $APP_DB_CONTAINER_NAME) ]; then
        return 0
    else
        return 1
    fi;
}

function db_process {
    if app_existing -eq 1; then
        app_build
    fi

    if app_running -eq 1; then
        docker start $APP_CONTAINER_NAME | echo "Starting $(cat)"
    fi

    if database_running -eq 1; then
        docker start $APP_DB_CONTAINER_NAME | echo "Starting $(cat)"
    fi

    docker exec -i $APP_CONTAINER_NAME sh -c "flask db $1"
}

case $1 in
    "build")
        case $2 in
            "app")
                app_build
                ;;
            "test")
                test_build
                ;;
            "all")
                app_build
                test_build
                ;;
            *)
                echo "Unsupported option [$2] for build <option>. Available options: [app, test, all]"
                ;;
        esac
        ;;
    "start")
        case $2 in
            "app")
                app_start
                ;;
            "test")
                test_start
                ;;
            *)
                echo "Unsupported option [$2] for start <option>. Available options: [app, test]"
                ;;
        esac
        ;;
    "rm")
        case $2 in
            "app")
                app_rm
                ;;
            "test")
                test_rm
                ;;
            "all")
                app_rm
                test_rm
                ;;
            *)
                echo "Unsupported option [$2] for rm <option>. Available options: [app, test, all]"
                ;;
        esac
        ;;
    "db")
        db_process $2
        ;;
    *)
        echo "Unsupported command [$1]. Available commands: [build, start, rm, db]"
        ;;
esac
