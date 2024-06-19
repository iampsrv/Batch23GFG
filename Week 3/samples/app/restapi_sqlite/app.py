from flask import Flask, jsonify, request
import sqlite3

app = Flask(__name__)

DATABASE = 'items.db'

def create_items_table():
    conn = sqlite3.connect(DATABASE)
    cursor = conn.cursor()
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS items (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            key TEXT NOT NULL,
            value TEXT NOT NULL
        )
    ''')
    conn.commit()
    conn.close()

def get_all_items_from_db():
    conn = sqlite3.connect(DATABASE)
    cursor = conn.cursor()
    cursor.execute('SELECT key, value FROM items')
    items = cursor.fetchall()
    conn.close()
    return items

def get_item_from_db(key):
    conn = sqlite3.connect(DATABASE)
    cursor = conn.cursor()
    cursor.execute('SELECT key, value FROM items WHERE key = ?', (key,))
    item = cursor.fetchone()
    conn.close()
    return item

def create_item_in_db(key, value):
    conn = sqlite3.connect(DATABASE)
    cursor = conn.cursor()
    cursor.execute('INSERT INTO items (key, value) VALUES (?, ?)', (key, value))
    conn.commit()
    conn.close()

def update_item_in_db(key, value):
    conn = sqlite3.connect(DATABASE)
    cursor = conn.cursor()
    cursor.execute('UPDATE items SET value = ? WHERE key = ?', (value, key))
    conn.commit()
    conn.close()

def delete_item_from_db(key):
    conn = sqlite3.connect(DATABASE)
    cursor = conn.cursor()
    cursor.execute('DELETE FROM items WHERE key = ?', (key,))
    conn.commit()
    conn.close()

@app.route('/items', methods=['GET'])
def get_all_items():
    items = get_all_items_from_db()
    return jsonify(items)

@app.route('/items/<string:key>', methods=['GET'])
def get_item(key):
    item = get_item_from_db(key)
    if item:
        return jsonify(item)
    else:
        return jsonify({'error': 'Item not found'}), 404

@app.route('/items', methods=['POST'])
def create_item():
    item = request.get_json()
    if 'key' not in item or 'value' not in item:
        return jsonify({'error': 'Invalid item data'}), 400
    key = item['key']
    value = item['value']
    create_item_in_db(key, value)
    return jsonify({'message': 'Item created successfully'}), 201

@app.route('/items/<string:key>', methods=['PUT'])
def update_item(key):
    item = request.get_json()
    if 'value' not in item:
        return jsonify({'error': 'Invalid item data'}), 400
    value = item['value']
    existing_item = get_item_from_db(key)
    if existing_item:
        update_item_in_db(key, value)
        return jsonify({'message': 'Item updated successfully'})
    else:
        return jsonify({'error': 'Item not found'}), 404

@app.route('/items/<string:key>', methods=['DELETE'])
def delete_item(key):
    existing_item = get_item_from_db(key)
    if existing_item:
        delete_item_from_db(key)
        return jsonify({'message': 'Item deleted successfully'})
    else:
        return jsonify({'error': 'Item not found'}), 404

if __name__ == '__main__':
    create_items_table()
    #app.run(debug=True)
    app.run(host='0.0.0.0',port=5001, debug=True) #host='0.0.0.0',
