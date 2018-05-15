#!/usr/bin/python
#coding:utf-8
import json
import sys
import requests

post_head = {'Content-Type': 'application/json;charset=utf-8'}
api_url = "https://oapi.dingtalk.com/robot/send?access_token=07911ab5bd82208a668bd95864026f5aeb950c677e389310f2ac40cf402b36aa"


def msg(text):
    json_text = {
        "msgtype": "text",
        "at": {
            "atMobiles": [
                "18058148144"
            ],
            "isAtAll": False
        },
        "text": {
            "content": text
        }
    }
    requests.post(api_url, json.dumps(json_text),headers=post_head).content


if __name__ == '__main__':
    text = sys.argv[1]
    msg(text)

