# run.py
# ────────────────────────────────────────────────────────────── #
#  CYBERKIDZSEC ⚡ VAULT — Development Entry Point
# ────────────────────────────────────────────────────────────── #

from src.app import create_app

app = create_app()

if __name__ == "__main__":
    # Run with: `python run.py`
    app.run(debug=True, host="0.0.0.0", port=5000)

