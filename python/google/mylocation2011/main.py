from google.appengine.ext import db


class ChatEvent(db.Model):
    timestamp = db.DateTimeProperty(auto_now_add=True)
