#!/usr/bin/python3
"""
    Rcursive function that queries the Reddit API, parses the title of all hot
    articles, and prints a sorted count of given keywords (case-insensitive,
    delimited by spaces.
"""

import requests


def count_words(subreddit, word_list):
    """ Prints a sorted count of given keywords """
    url = f"https://www.reddit.com/r/{subreddit}/hot.json?limit=100"
    headers = {'User-Agent': 'Linux Bukky'}
    response = requests.get(url, headers=headers, allow_redirects=False)
    if response.status_code != 200:
        return
    data = response.json()['data']['children']
    if not data:
        return
    counts = {}
    for post in data:
        title = post['data']['title'].lower()
        for word in word_list:
            if f' {word.lower()} ' in f' {title} ':
                counts[word.lower()] = counts.get(word.lower(), 0) + 1
    sorted_counts = sorted(counts.items(), key=lambda x: (-x[1], x[0]))
    for word, count in sorted_counts:
        print(f"{word}: {count}")
