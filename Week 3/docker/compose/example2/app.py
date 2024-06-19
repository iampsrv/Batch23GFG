from flask import Flask, jsonify
import requests

app = Flask(__name__)

def get_time():
    response = requests.get('http://time-service:5001/')
    return response.json()['time']

def get_weather():
    response = requests.get('http://weather-service:5002/')
    return response.json()['weather']

@app.route('/')
def greet():
    time = get_time()
    weather = get_weather()
    greeting_message = f"Hello! The current time is {time} and the weather is {weather}."
    return jsonify(message=greeting_message)

if __name__ == '__main__':
    app.run(debug=True,host='0.0.0.0', port=5000)
