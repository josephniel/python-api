from collections import namedtuple


ROUTES = []


def route(location: str, name: str):
    def wrapper(cls):
        class_route = namedtuple('ClassRoute', ['location', 'view_func'])
        ROUTES.append(class_route(
            location=location, view_func=cls.as_view(name)
        ))
        return cls
    return wrapper
