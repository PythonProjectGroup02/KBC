# -*- coding: utf-8 -*-
"""
author : Lcy
Description : Swift에서 요청
http://localhost:5000/

"""

from flask import Flask, jsonify, request
import json
import pymysql
import pandas as pd
import time

app = Flask(__name__)
app.config['JSON_AS_ASCII'] = False # utf8


@app.route('/monthRank')
def teamRanking() :
    # 사용자가 선택하는 값
    select_year = request.args.get('year')
    select_month = request.args.get('month')

    # ---
    
    team_name_arr = ["두산", "롯데", "삼성", "키움", "한화", "KIA", "KT", "LG", "NC", "SSG"]
    response = {}

    for teamName in team_name_arr :
        team_df = pd.read_csv(f'./Python/Data/rank/{teamName}_rank.csv')
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

    df = pd.read_csv('./Python/Data/rank/day_rank.csv')
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
    
    pd.DataFrame(result).to_csv('./Python/Data/rank/day_rank.csv', index=None)


# @app.route('/update')
# def updateMySQL() :
#     code = request.args.get('code')
#     name = request.args.get('name')
#     dept = request.args.get('dept')
#     phone = request.args.get('phone')

#     # MySQL Connection
#     conn = pymysql.connect(
#         host='127.0.0.1',
#         user='root',
#         password='qwer1234',
#         database='python',
#         charset='utf8'
#     )

#     # Connection으로부터 Cursor 생성
#     curs = conn.cursor()

#     # SQL 문장
#     sql = 'update students set name=%s, dept=%s, phone=%s where code=%s'
#     curs.execute(sql, (name,dept,phone,code))
#     conn.commit()
#     conn.close()

#     return jsonify([{'result' : 'OK'}])

# @app.route('/insert')
# def insertMySQL() :
#     code = request.args.get('code')
#     name = request.args.get('name')
#     dept = request.args.get('dept')
#     phone = request.args.get('phone')

#     # MySQL Connection
#     conn = pymysql.connect(
#         host='127.0.0.1',
#         user='root',
#         password='qwer1234',
#         database='python',
#         charset='utf8'
#     )

#     # Connection으로부터 Cursor 생성
#     curs = conn.cursor()

#     # SQL 문장
#     sql = 'insert into students (code,name,dept,phone) values (%s, %s, %s, %s)'
#     curs.execute(sql, (code,name,dept,phone))
#     conn.commit()
#     conn.close()

#     return jsonify([{'result' : 'OK'}])

# @app.route('/delete')
# def deleteMySQL() :
#     code = request.args.get('code')

#     # MySQL Connection
#     conn = pymysql.connect(
#         host='127.0.0.1',
#         user='root',
#         password='qwer1234',
#         database='python',
#         charset='utf8'
#     )

#     # Connection으로부터 Cursor 생성
#     curs = conn.cursor()

#     # SQL 문장
#     sql = 'delete from students where code=%s'
#     curs.execute(sql, code)
#     conn.commit()
#     conn.close()

#     return jsonify([{'result' : 'OK'}])

if __name__ == '__main__' :
    app.run(host='127.0.0.1', port=5000, debug=True)
