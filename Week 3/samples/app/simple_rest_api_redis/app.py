from flask import Flask, jsonify, request
from redis import Redis

app = Flask(__name__)
#redis = Redis(host='localhost', port=6379)
redis = Redis(host='redis', port=6379)
redis.delete('hits')

# Create an empty list to store the data
data = []


@app.route('/', methods=['GET'])
def home():
    redis.incr('hits')
    return 'This page has been viewed %s time(s).' % redis.get('hits')

@app.route('/items', methods=['GET'])
def get_all_items():
    return jsonify(data)


@app.route('/items/<string:key>', methods=['GET'])
def get_item(key):
    for item in data:
        if item['key'] == key:
            return jsonify(item)
    return jsonify({'error': 'Item not found'}), 404


@app.route('/items', methods=['POST'])
def create_item():
    item = request.get_json()
    if 'key' not in item or 'value' not in item:
        return jsonify({'error': 'Invalid item data'}), 400
    data.append(item)
    return jsonify({'message': 'Item created successfully'}), 201


@app.route('/items/<string:key>', methods=['PUT'])
def update_item(key):
    for item in data:
        if item['key'] == key:
            item_data = request.get_json()
            if 'value' not in item_data:
                return jsonify({'error': 'Invalid item data'}), 400
            item['value'] = item_data['value']
            return jsonify({'message': 'Item updated successfully'})
    return jsonify({'error': 'Item not found'}), 404


@app.route('/items/<string:key>', methods=['DELETE'])
def delete_item(key):
    for item in data:
        if item['key'] == key:
            data.remove(item)
            return jsonify({'message': 'Item deleted successfully'})
    return jsonify({'error': 'Item not found'}), 404


if __name__ == '__main__':
    app.run(host='0.0.0.0',port=5001, debug=True)
