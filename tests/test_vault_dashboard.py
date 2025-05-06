def test_vault_dashboard_routes(client):
    res = client.get('/vault_dashboard')
    assert res.status_code in [200, 302]
