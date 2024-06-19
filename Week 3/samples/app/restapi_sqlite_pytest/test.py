import pytest
from flask import Flask
from flask.testing import FlaskClient
from app import create_items_table, app


@pytest.fixture
def client() -> FlaskClient:
    app.config['TESTING'] = True
    with app.test_client() as client:
        with app.app_context():
            create_items_table()
        yield client


def test_get_all_items(client):
    response = client.get('/items')
    assert response.status_code == 200
    #assert response.json == []


def test_create_item(client):
    data = {'key': 'test_key', 'value': 'test_value'}
    response = client.post('/items', json=data)
    assert response.status_code == 201
    assert response.json == {'message': 'Item created successfully'}


def test_get_item(client):
    response = client.get('/items/test_key')
    assert response.status_code == 200
    assert response.json == ['test_key', 'test_value']


def test_update_item(client):
    data = {'value': 'updated_value'}
    response = client.put('/items/test_key', json=data)
    assert response.status_code == 200
    assert response.json == {'message': 'Item updated successfully'}


def test_delete_item(client):
    response = client.delete('/items/test_key')
    assert response.status_code == 200
    assert response.json == {'message': 'Item deleted successfully'}


def test_get_item_not_found(client):
    response = client.get('/items/non_existent_key')
    assert response.status_code == 404
    assert response.json == {'error': 'Item not found'}


def test_update_item_not_found(client):
    data = {'value': 'updated_value'}
    response = client.put('/items/non_existent_key', json=data)
    assert response.status_code == 404
    assert response.json == {'error': 'Item not found'}


def test_delete_item_not_found(client):
    response = client.delete('/items/non_existent_key')
    assert response.status_code == 404
    assert response.json == {'error': 'Item not found'}
