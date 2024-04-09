#!/usr/bin/python3
"""
    Recursive function that queries the Reddit API and returns a list
    containing the titles of all hot articles for a given subreddit.
    If no results are found for the given subreddit, the function
    should return None.
"""

import requests


def recurse(subreddit, hot_list=[]):
    """Returns list containing the titles of all hot articles in subreddit"""
    url = f"https://www.reddit.com/r/{subreddit}/hot.json?limit=100"
    headers = {'User-Agent': 'Linux: Bukky'}
    response = requests.get(url, headers=headers, allow_redirects=False)
    if response.status_code != 200:
        return None
    data = response.json()['data']['children']
    if len(data) == 0:
        return None
    hot_list.extend([post['data']['title'] for post in data])
    if 'after' in response.json()['data'] \
       and response.json()['data']['after'] is not None:
        return recurse(subreddit, hot_list)
    else:
        return hot_list
