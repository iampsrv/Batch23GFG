import pytest
from app import app as flask_app, todos  # Import todos here

@pytest.fixture
def app():
    yield flask_app

@pytest.fixture
def client(app):
    return app.test_client()

def test_index(app, client):
    response = client.get('/')
    assert response.status_code == 200

def test_add_todo(client):
    response = client.post('/add', data={'todo': 'Test Todo'})
    assert response.status_code == 302  # Redirect status code
    assert 'Test Todo' in todos.values()  # Use imported todos

def test_delete_todo(client):
    # First, add a todo item
    client.post('/add', data={'todo': 'Delete Me'})

    # Assume the ID of the first (and only) todo item is '1'
    todo_id = list(todos.keys())[0]
    response = client.get('/delete/{}'.format(todo_id))
    assert response.status_code == 302  # Redirect status code
    assert todo_id not in todos  # Use imported todos
