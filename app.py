# Imports
import os
import threading
import time

import pymysql
from flask import Flask, render_template, request
from turbo_flask import Turbo

# FLASK & TURBO SETUP
app = Flask(__name__)
app.config["SERVER_NAME"] = os.environ.get("SERVER_NAME", "127.0.0.1:5000")

turbo = Turbo(app)

# How often the background poller checks the DB for changes and pushes updates
PUSH_INTERVAL_SECONDS = 5

# DATABASE CONNECTION
connection = pymysql.connect(
    host=os.environ.get("HOST"),
    user=os.environ.get("USER"),
    database=os.environ.get("DATABASE"),
    cursorclass=pymysql.cursors.DictCursor,
    autocommit=True,
)

def execute_sql(command, values=None):
    """Runs a query on a thread-safe cursor, reconnecting if needed."""
    connection.ping(reconnect=True)
    cursor = connection.cursor()
    cursor.execute(command, values)
    return cursor

# FLASK ROUTES
@app.route("/")
def index():
    return render_template("index.html", active_page="home")

if __name__ == "__main__":
    app.run(debug=True, threaded=True)