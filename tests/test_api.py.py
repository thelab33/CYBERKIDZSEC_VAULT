def test_api.py_routes(client):
    res = client.get('/api.py')
    assert res.status_code in [200, 302]
