# -*- coding: utf-8 -*-
"""
author : 김소리
Description : Swift에서 요청
http://localhost:5000/
"""

from flask import Flask, jsonify, request
import pandas as pd
import json

app = Flask(__name__)
app.config['JSON_AS_ASCII'] = False  # utf8 설정

@app.route('/searchmatch')
def searchteam():
    myteam = request.args.get('myteam')
    month = request.args.get('month')
    day = request.args.get('day')

    match myteam :
        case '롯데':
            teamschedule = pd.read_csv('./schedule/lotte.csv')
        case '기아':
            teamschedule = pd.read_csv('./schedule/kia.csv')
        case '한화':
            teamschedule = pd.read_csv('./schedule/hh.csv')
        case '삼성':
            teamschedule = pd.read_csv('./schedule/ss.csv')
        case '두산':
            teamschedule = pd.read_csv('./schedule/doosan.csv')
        case 'LG':
            teamschedule = pd.read_csv('./schedule/lg.csv')
        case 'NC':
            teamschedule = pd.read_csv('./schedule/nc.csv')
        case 'KT':
            teamschedule = pd.read_csv('./schedule/kt.csv')
        case 'SSG':
            teamschedule = pd.read_csv('./schedule/ssg.csv')
        case '키움':
            teamschedule = pd.read_csv('./schedule/kiwoom.csv')
    
    print(teamschedule)

    # 월과 일로 필터링
    filtered = teamschedule[(teamschedule['월'] == int(month)) & (teamschedule['일'] == int(day))]
    
    filtered
    
    away = filtered.iloc[0]['어웨이']
    home = filtered.iloc[0]['홈']
    stadium = filtered.iloc[0]['경기장']

    # JSON 응답 생성
    response = {
        'away': away,
        'home': home,
        'stadium': stadium
    }

    return json.dumps([response], ensure_ascii=False).encode('utf-8')

if __name__ == '__main__':
    app.run(host='127.0.0.1', port=5000, debug=True)
