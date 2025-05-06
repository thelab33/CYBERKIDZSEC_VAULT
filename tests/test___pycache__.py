def test___pycache___routes(client):
    res = client.get('/__pycache__')
    assert res.status_code in [200, 302]
