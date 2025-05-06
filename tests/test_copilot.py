def test_copilot_routes(client):
    res = client.get('/copilot')
    assert res.status_code in [200, 302]
