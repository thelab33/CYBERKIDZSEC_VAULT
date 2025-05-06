def test_status_routes(client):
    res = client.get('/status')
    assert res.status_code in [200, 302]
