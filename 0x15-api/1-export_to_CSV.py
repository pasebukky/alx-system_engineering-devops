#!/usr/bin/python3
"""
    Python script that records all tasks that are owned by this employee
"""

import csv
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

    csv_filename = f"{user_id}.csv"

    with open(csv_filename, 'w', newline='') as csvfile:
        csv_writer = csv.writer(csvfile, quoting=csv.QUOTE_ALL)
        for task in todos_list:
            csv_writer.writerow([user_id, user_info.get("username"),
                                 task.get("completed"), task.get("title")])
