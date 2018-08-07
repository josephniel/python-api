# Python API

## Installation
This repository is self-served. You only need to take care of the following:
  - `docker`
  - `docker-compose`
  - configuration in the `api/config` directory for the specified environment.

When all these are met, you can do the following for the first time in your local machine:
```
./app.sh build
```
This will build the necessary containers. After running them, we want to set up the database.
```
./app.sh db upgrade
```
This command will update the contained DB used by the application based on the migration scripts present in the codebase in `migrations/versions` (i.e. will only update if it migration hasn't been performed yet).

After making sure that the database is up to date, we can now run the application by:
```
./app.sh start
```

## Development
In developing API endpoints for this codebase, we only need to work mainly on these repositories:
  - `api/controllers`
    - serves as the entrypoint for the application
    - uses Flask's [MethodView](http://flask.pocoo.org/docs/1.0/api/#flask.views.MethodView) as a general request mapper
    - uses a custom decorator for registering routes (i.e. `api/router.py`) and is used as follows:
        ```
        @route('your/route/<int:id>', 'your-route-name')
        ```
        Syntax for the route definition can be found [here](http://flask.pocoo.org/docs/1.0/quickstart/#routing).
  - `api/handlers`
    - serves as the business logic layer for the application.
    - should contain all the processing done
  - `api/models`
    - contains all the models used by the application
    - directly mapped to the database
    - tightly coupled to the database migration

## Migrations
The codebase uses alembic to keep track of the database change done in the model. Whenever a model is updated/added, we also want to generate a migration script for the change. To do this, we only need to run the following command:
```
./app.sh db migrate --message "Short description here"
```
A migration script will be generated in `migrations/versions`.

To update your local database after doing the migration, we just run the command:
```
./app.sh db upgrade
```
You can also do a downgrade by:
```
./app.sh db downgrade
```
This will downgrade the version of your database to one version down. To specify where the downgrade should stop, we can use the revision hash generated per script as follows:
```
./app.sh db downgrade <revision_id>
```
The indicated id will also be included in the downgrade. You can see more of the commands used in [Flask-Migrate](https://flask-migrate.readthedocs.io/en/latest/).

## Running Unit Tests
There is a separate docker container built when running unit tests. This is for the main application to not be mixed development and integration entities. 
