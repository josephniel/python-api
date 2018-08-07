from flask import Flask
from flask_migrate import Migrate

from models import db
from router import ROUTES
from utils import import_submodules


migrate = Migrate()


def create_app(env: str = 'dev') -> Flask:
    app = Flask(__name__)
    env_to_conf_map = {
        'dev': 'config.development.DevelopmentConfig',
        'staging': 'config.staging.StagingConfig',
        'live': 'config.production.ProductionConfig',
    }
    app.config.from_object(env_to_conf_map[env])

    db.init_app(app)
    migrate.init_app(app, db)

    import_submodules('controllers')
    app.url_map.strict_slashes = False
    for route in ROUTES:
        app.add_url_rule(
            "{location}".format(location=route.location),
            view_func=route.view_func,
        )

    return app
