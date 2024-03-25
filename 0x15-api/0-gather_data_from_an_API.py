#!/usr/bin/python3
"""
    Python script that, using a url REST API, for a given employee ID,
    returns information about his/her TODO list progress
"""

import requests
import sys


if __name__ == "__main__":

    base_url = "https://jsonplaceholder.typicode.com/"

    user_id = sys.argv[1]
    user_response = requests.get(base_url + "users/{}".format(user_id))
    user_info = user_response.json()

    todos_response = requests.get(base_url + "todos",
                                  params={"userId": user_id})
    todos_list = todos_response.json()

    completed_tasks = []
    for task in todos_list:
        if task.get("completed"):
            completed_tasks.append(task.get("title"))

    print("Employee {} is done with tasks({}/{}):".format(
        user_info.get("name"), len(completed_tasks), len(todos_list)))

    for task_title in completed_tasks:
        print("\t {}".format(task_title))
