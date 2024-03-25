#!/usr/bin/python3
"""
    Python script that records all tasks that are owned by this employee
"""

import json
import requests
import sys


if __name__ == "__main__":

    base_url = "https://jsonplaceholder.typicode.com/"

    user_id = sys.argv[1]
    user_response = requests.get(base_url + "users/{}".format(user_id))
    user_info = user_response.json()
    username = user_info.get("username")

    todos_response = requests.get(base_url + "todos",
                                  params={"userId": user_id})
    todos_list = todos_response.json()

    with open("{}.json".format(user_id), "w") as jsonfile:
        json.dump({user_id: [{
            "task": t.get("title"),
            "completed": t.get("completed"),
            "username": username
        } for t in todos_list]}, jsonfile)
