class BaseConfig:
    ENV = 'testing'
    DEBUG = False

    HOST = '0.0.0.0'
    PORT = 5000

    SQLALCHEMY_TRACK_MODIFICATIONS = False
    SQLALCHEMY_DATABASE_URI = \
        'postgres://postgres:postgres@database/messenger'
