from flask import Flask, jsonify
import datetime

app = Flask(__name__)

@app.route('/')
def get_time():
    current_time = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    return jsonify(time=current_time)

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5001)
