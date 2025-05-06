def test_bug_vault_routes(client):
    res = client.get('/bug_vault')
    assert res.status_code in [200, 302]
