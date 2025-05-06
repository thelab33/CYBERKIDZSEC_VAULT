def test_vuln_scanner_routes(client):
    res = client.get('/vuln_scanner')
    assert res.status_code in [200, 302]
