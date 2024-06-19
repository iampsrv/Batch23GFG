from flask import Flask, render_template, request, redirect, url_for
import uuid

app = Flask(__name__)

# This dictionary will act as a simple database
todos = {}

@app.route('/')
def index():
    return render_template('index.html', todos=todos)

@app.route('/add', methods=['POST'])
def add_todo():
    task = request.form.get('todo')
    todos[str(uuid.uuid4())] = task  # Using UUID to generate unique IDs
    return redirect(url_for('index'))

@app.route('/delete/<id>')
def delete(id):
    todos.pop(id, None)
    return redirect(url_for('index'))

if __name__ == "__main__":
    # app.run(port=5000,debug=True)
    app.run(host='0.0.0.0',port=5000,debug=True)