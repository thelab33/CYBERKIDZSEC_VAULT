def test_smart_contract_playground_routes(client):
    res = client.get('/smart_contract_playground')
    assert res.status_code in [200, 302]
