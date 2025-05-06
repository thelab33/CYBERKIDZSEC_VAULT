def test_api_playground_routes(client):
    res = client.get('/api_playground')
    assert res.status_code in [200, 302]
