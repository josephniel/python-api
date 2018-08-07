import argparse

from bootstrap import create_app

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument(
        '--env',
        help='The environment the application is deployed'
    )
    args = vars(parser.parse_args())

    app = create_app(args['env'])
    app.run(
        host=app.config.get('HOST', '0.0.0.0'),
        port=app.config.get('PORT', 5000),
        debug=app.config.get('DEBUG', False)
    )
