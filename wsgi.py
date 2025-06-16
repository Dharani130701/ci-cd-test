from MVP import application
from werkzeug.middleware.proxy_fix import ProxyFix
import os
from dotenv import load_dotenv

# Load environment variables from .env
load_dotenv()

application.wsgi_app = ProxyFix(application.wsgi_app)
application.config['PREFERRED_URL_SCHEME'] = 'https'

if __name__ == "__main__":
    application.run(
        debug=os.getenv('FLASK_DEBUG', True),
        host=os.getenv('FLASK_RUN_HOST', '0.0.0.0'),
        port=int(os.getenv('FLASK_RUN_PORT', 5000))
    )

