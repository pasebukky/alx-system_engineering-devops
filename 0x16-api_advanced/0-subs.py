#!/usr/bin/python3
"""
    Function that queries the Reddit API and returns the number of
    subscribers (not active users, total subscribers) for a given subreddit.
    If an invalid subreddit is given, the function should return 0.
"""

import requests
import sys


def number_of_subscribers(subreddit):
    """Return the total number of subscribers for a particular subreddit."""
    url = "https://www.reddit.com/r/{subreddit}/about.json"
    response = requests.get(url, allow_redirects=False)
    if response.status_code == 200:
        data = response.json()
        return data['data']['subscribers']
    else:
        return 0
