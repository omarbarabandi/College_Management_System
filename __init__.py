from flask import Flask
from flask_mysqldb import MySQL

from flask_login import (
    UserMixin,
    login_user,
    LoginManager,
    current_user,
    logout_user,
    login_required,
)

def create_app():
	app = Flask(__name__)


	app.config['DEBUG'] = True
	app.config['SECRET_KEY'] = 'o2sNbqx2acQJ^Jtm;wRQv+J$.i@8O#'
	app.config['MYSQL_HOST'] = 'regs-os.c3jxrkzrpgpc.us-east-1.rds.amazonaws.com'
	app.config['MYSQL_USER'] = 'admin'
	app.config['MYSQL_PASSWORD'] = 'regs17-2'
	app.config['MYSQL_DB'] = 'university'
	app.config['MYSQL_CURSORCLASS'] = 'DictCursor'
	app.config['FLASK_ADMIN_SWATCH'] = 'cerulean'

	
	return app
app = create_app()
db = MySQL(app)
