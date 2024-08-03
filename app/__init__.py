import logging
from logging.config import dictConfig
from flask import Flask
from flask_cors import CORS
from app.framework.config import Config
from werkzeug.middleware.proxy_fix import ProxyFix


dictConfig({
    'version': 1,
    'formatters': {'default': {
        'format': '[%(asctime)s] %(levelname)s in %(module)s: %(message)s',
    }},
    'handlers': {
        'wsgi': {
            'class': 'logging.StreamHandler',
            'stream': 'ext://flask.logging.wsgi_errors_stream',
            'formatter': 'default'
        },
        'custom_handler': {
            'class': 'logging.FileHandler',
            'formatter': 'default',
            'filename': r'logs/app.log'
        }
    },
    'root': {
        'level': 'INFO',
        'handlers': ['wsgi', 'custom_handler']
    }
})


def create_app():
    app = Flask(__name__,
                static_url_path='/static',
                static_folder='../static',
                template_folder='../templates'
                )
    
    app.config.from_object(Config)
    logging.getLogger('fontTools').setLevel(logging.WARNING)
    logging.getLogger('weasyprint').setLevel(logging.ERROR)
    
    CORS(app, expose_headers=["x-suggested-filename"])

    return app
