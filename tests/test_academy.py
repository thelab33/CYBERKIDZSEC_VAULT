def test_academy_routes(client):
    res = client.get('/academy')
    assert res.status_code in [200, 302]
