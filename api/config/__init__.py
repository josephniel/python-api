class BaseConfig:
    ENV = 'testing'
    DEBUG = False

    HOST = 'localhost'
    PORT = 5000

    SQLALCHEMY_TRACK_MODIFICATIONS = False
    SQLALCHEMY_DATABASE_URI = 'postgres://jtuazon:sample@localhost:5432/sample2'
