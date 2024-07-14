from flask import Flask
import os

app = Flask(__name__)

@app.route('/')
def hello():
    name = os.environ.get('NAME')
    if name:
        return f'Hello! Your name is: {name}'
    else:
        return 'name not found.'

if __name__ == '__main__':
    app.run(host='0.0.0.0',port=5001,debug=True)
