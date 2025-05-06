def test_views.py_routes(client):
    res = client.get('/views.py')
    assert res.status_code in [200, 302]
