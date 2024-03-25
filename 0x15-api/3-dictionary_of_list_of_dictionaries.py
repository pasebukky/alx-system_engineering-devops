#!/usr/bin/python3
"""
    Python script that records all tasks from all employees
"""

import json
import requests
import sys


if __name__ == "__main__":

    base_url = "https://jsonplaceholder.typicode.com/"

    users_response = requests.get(base_url + "users")
    users = users_response.json()

    todo_data = {}

    for user in users:
        user_id = user.get("id")
        username = user.get("username")

        todos_response = requests.get(base_url + "todos",
                                      params={"userId": user_id})
        todos_list = todos_response.json()

        user_todo_data = [{"username": username,
                           "task": task.get("title"),
                           "completed": task.get("completed")}
                          for task in todos_list]
        todo_data[user_id] = user_todo_data

    with open("todo_all_employees.json", "w") as jsonfile:
        json.dump(todo_data, jsonfile)
