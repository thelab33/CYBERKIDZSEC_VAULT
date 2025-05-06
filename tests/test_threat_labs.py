def test_threat_labs_routes(client):
    res = client.get('/threat_labs')
    assert res.status_code in [200, 302]
