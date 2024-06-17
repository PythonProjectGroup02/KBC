# -*- coding: utf-8 -*-
"""
author : 
Description : KBC Server
http://localhost:5000/

"""

from flask import Flask, jsonify, request
import json
import pymysql
import pandas as pd
import joblib
import numpy as np
import holidays
import datetime

app = Flask(__name__)
app.config['JSON_AS_ASCII'] = False # utf8

# --- 팀명 ---
# KIA
# LG
# 두산
# 삼성
# SSG
# NC
# 한화
# 롯데
# KT
# 키움

# ---- 차트 -----
@app.route('/monthRank')
def teamRanking() :
    # 사용자가 선택하는 값
    select_year = request.args.get('year')
    select_month = request.args.get('month')

    # ---
    
    team_name_arr = ["두산", "롯데", "삼성", "키움", "한화", "KIA", "KT", "LG", "NC", "SSG"]
    response = {}

    for teamName in team_name_arr :
        team_df = pd.read_csv(f'../Python/Data/rank/{teamName}_rank.csv')
        team_df = team_df.iloc[:, :3]
        team_df.columns = ['date', 'team', 'rank']
        team_df.date = pd.to_datetime(team_df.date)
        result_df = team_df[(team_df.date.dt.year == int(select_year)) & (team_df.date.dt.month == int(select_month))]
        result_df.date = result_df.date.astype(str)

        if teamName not in response.keys() :
            response[teamName] = []

        for i in range(len(result_df)) :
            response[teamName].append(result_df.iloc[i,:].to_dict())

    # return
    return json.dumps(response, ensure_ascii=False).encode('utf-8')

@app.route('/dayRank')
def dayRanking() :
    # 크롤링
    crawling_kbo_dayRanking()

    df = pd.read_csv('../Python/Data/rank/day_rank.csv')
    df.columns = ['rank', 'team', 'totalgames', 'win', 'loss', 'draw', 'winningrate', 'gamesbehind', 'tengamesrecord', 'streak', 'home', 'away', 'date']

    result = []

    for index in range(len(df)) :
        result.append(df.loc[index, :].to_dict())

    # return
    return json.dumps(result, ensure_ascii=False).encode('utf-8')

def crawling_kbo_dayRanking() :
    from bs4 import BeautifulSoup
    import urllib.request as req
    import pandas as pd

    url = 'https://www.koreabaseball.com/Record/TeamRank/TeamRankDaily.aspx'
    res = req.urlopen(url)
    soup = BeautifulSoup(res, 'html.parser')
    date = soup.find_all('span', attrs='date')[0].text

    # print('현재 날짜 : ', current_date)
    # print('KBO 날짜 : ', date)

    # if current_date == date :
    #     return

    result = []
    
    for index in range(10) :
        team_info = soup.select('table > tbody tr')[index]
        datas = team_info.select('td')

        result_dict = {
            '순위' : datas[0].text,
            '팀명' : datas[1].text,
            '경기 수' : datas[2].text,
            '승리 수' : datas[3].text,
            '패배 수' : datas[4].text,
            '무승부 수' : datas[5].text,
            '승률' : datas[6].text,
            '게임차' : datas[7].text,
            '최근 10경기 전적' : datas[8].text,
            '연속 현황' : datas[9].text,
            '홈 경기 전적' : datas[10].text,
            '원정 경기 전적' : datas[11].text,
            '날짜' : date
        }

        result.append(result_dict)
    
    pd.DataFrame(result).to_csv('../Python/Data/rank/day_rank.csv', index=None)

@app.route('/searchmatch')
def searchteam():
    myteam = request.args.get('myteam')
    month = request.args.get('month')
    day = request.args.get('day')

    match myteam :
        case '롯데':
            teamschedule = pd.read_csv('./schedule/lotte.csv')
        case 'KIA':
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

    if filtered.empty:
        response = {
            'away': '',
            'home': '',
            'stadium': '',
            'state' : 0
        }
    else:
        away = filtered.iloc[0]['어웨이']
        home = filtered.iloc[0]['홈']
        stadium = filtered.iloc[0]['경기장']

        response = {
            'away': away,
            'home': home,
            'stadium': stadium,
            'state' : 1
        }

    return json.dumps([response], ensure_ascii=False).encode('utf-8')

@app.route('/cheerContent')
def cheerSelectMySQL() :
    team = request.args.get('team')

    conn = pymysql.connect(
        host='127.0.0.1',
        user='root',
        password='qwer1234',
        database='python',
        charset='utf8'
    )

    # Connection으로부터 Cursor 생성
    curs = conn.cursor()

    # SQL 문장
    sql = "select * from cheer where cteam = %s order by cdate desc"
    curs.execute(sql, team)
    rows = curs.fetchall()
    conn.close()

    response = []
    for row in rows :
        result_dict = {
            "id" : row[0],
            "content" : row[1],
            "date" : row[2].strftime("%y-%m-%d %H:%M:%S"),
            "nickname" : row[3],
            "team" : row[4]
        }
        response.append(result_dict)

    state = 1

    if len(response) == 0 :
        state = 0

    result = {
        'state' : state,
        'data' : response
    }

    return json.dumps(result, ensure_ascii=False).encode('utf-8')

@app.route("/insertCheer")
def cheerInsertMySQL() :
    cteam = request.args.get('myteam')
    ctext = request.args.get('text')
    cname = request.args.get('nickname')

    conn = pymysql.connect(
        host='127.0.0.1',
        user='root',
        password='qwer1234',
        database='python',
        charset='utf8'
    )

    # Connection으로부터 Cursor 생성
    curs = conn.cursor()

    try :
        # SQL 문장
        sql = "insert into cheer (ctext, cdate, cname, cteam) values (%s, now(), %s, %s)"
        curs.execute(sql, (ctext, cname, cteam))
        conn.commit()
        conn.close()
        return json.dumps({"result" : "success"}, ensure_ascii=False).encode('utf-8')
    except :
        conn.close()
        return json.dumps({"result" : "error"}, ensure_ascii=False).encode('utf-8')
    
# ---- 예측 ----
@app.route("/predict")
def predictCrowd():
    # 데이터 받기
    month=int(request.args.get("month"))
    day=int(request.args.get("day"))
    # rank=int(request.args.get("순위"))
    away=request.args.get("원정팀")
    myTeam = request.args.get("myTeam")
    print("myTeam :", myTeam)

    date = datetime.date(2024, month, day)
    dateWeek = date.weekday()


    # df = pd.read_csv(f"./Data/rank/{home}_rank.csv")
    df = pd.read_csv("./Data/rank/day_rank.csv")
    rank = df[df.팀명 == myTeam].순위.values[0]
    # away_rank = df[df.팀명 == away].순위.values[0]


    # 요일에 따라 조건문 작성
    if dateWeek in (4,5,6):
        daybyday = 1
    elif dateWeek in (0,1,2,3):
        daybyday = 0
    else:
        daybyday = None



    # 한국 공휴일 데이터
    korean_holidays = holidays.KR()
    # 휴일 유무
    holiday = 1 if date in korean_holidays else 0


    # 상위권 중위권 하위권 구분
    if 1 <= rank <= 3:
        hmlRank = 0
    elif 4 <= rank <= 6:
        hmlRank = 1
    elif 7 <= rank <= 10:
        hmlRank = 2
    else:
        hmlRank = None

    # 상위권 하위권 구분
    if 1 <= rank <= 5:
        hlRank = 0
    elif 6 <= rank <= 10:
        hlRank = 1
    else:
        hlRank = None

    # 예측 모델 실행
    clf = joblib.load(f"./Data/predict_model/svm_{myTeam}.h5")
    thiss = np.array(
        [
            [holiday,hmlRank,hlRank]
        ]
    )
    pre = clf.predict(thiss)
    print(pre)
    return jsonify([{'result':pre[0]}])

if __name__ == '__main__' :
    app.run(host='127.0.0.1', port=5000, debug=True)
