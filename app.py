import requests
from flask import Flask

app = Flask(__name__)


@app.get("/")
def hello():
    return {"message": "Hello from Instana (profiling) World"}


@app.route("/users/")
def read_users():
    resp = requests.get("https://reqres.in/api/users")
    # print(resp)
    return resp.json()


@app.get("/users/<int:user_id>")
def read_user(user_id: int):
    resp = requests.get(f"https://reqres.in/api/users/{user_id}")

    if resp.status_code != 200:
        return

    user = resp.json().get("data")
    return {
        "user_id": user.get("id", None),
        "email": user.get("email", None),
        "first_name": user.get("first_name", None),
        "last_name": user.get("last_name", None),
        "avatar": user.get("avatar", None),
    }


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
