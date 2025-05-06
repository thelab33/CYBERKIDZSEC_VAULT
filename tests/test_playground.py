def test_playground_routes(client):
    res = client.get('/playground')
    assert res.status_code in [200, 302]
