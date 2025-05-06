def test_dashboard_routes(client):
    res = client.get('/dashboard')
    assert res.status_code in [200, 302]
