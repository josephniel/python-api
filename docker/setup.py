from setuptools import setup, find_packages

setup(
    name='Job Distribution Engine',
    version='0.1',
    description='',
    author='Gengo Dev',
    author_email='dev@gengo.com',
    packages=find_packages(),
    install_requires=[
        'flask',
        'Flask-Migrate',
        'Flask-SQLAlchemy',
        'psycopg2-binary',
    ],
    extras_require={
        'test': [
            'nose',
            'flake8',
            'mypy'
        ]
    }
)
