from flask import Flask, jsonify
import random

app = Flask(__name__)

def get_random_weather():
    weather_conditions = ['sunny', 'cloudy', 'rainy', 'stormy', 'snowy']
    return random.choice(weather_conditions)

@app.route('/')
def get_weather():
    weather = get_random_weather()
    return jsonify(weather=weather)

if __name__ == '__main__':
    app.run(debug=True,host='0.0.0.0', port=5002)
