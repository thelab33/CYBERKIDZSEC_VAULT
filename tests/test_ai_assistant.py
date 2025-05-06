def test_ai_assistant_routes(client):
    res = client.get('/ai_assistant')
    assert res.status_code in [200, 302]
