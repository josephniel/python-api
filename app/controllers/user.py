from flask import Response, jsonify
from flask.views import MethodView

from models import db
from models.user import User
from router import route


@route('/users/<int:user_id>', 'user-api-entrypoint')
class UserAPI(MethodView):

    def get(self, user_id: int) -> Response:
        user = db.session.query(User).get(user_id)
        return jsonify({
            'id': user_id,
            'name': user.name,
        })


@route('/users', 'users-api-entrypoint')
class UsersAPI(MethodView):

    def get(self) -> Response:
        users = db.session.query(User).all()
        return jsonify({
            'users': [
                {
                    'id': user.id,
                    'name': user.name
                } for user in users
            ]
        })
