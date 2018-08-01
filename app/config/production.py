from config import BaseConfig


class ProductionConfig(BaseConfig):
    ENV = 'production'
    DEBUG = False
