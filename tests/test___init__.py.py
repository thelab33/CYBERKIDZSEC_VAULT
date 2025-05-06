def test___init__.py_routes(client):
    res = client.get('/__init__.py')
    assert res.status_code in [200, 302]
