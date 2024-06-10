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

app = Flask(__name__)
app.config['JSON_AS_ASCII'] = False # utf8


@app.route('/monthRank')
def teamRanking() :
    # 사용자가 선택하는 값
    select_year = request.args.get('year')
    select_month = request.args.get('month')
    team_name = request.args.get('team')

    print(int(select_month))

    # ------

    # 서버에서 불러와 원하는 값 추출
    team_df = pd.read_csv(f'./Python/Data/rank/{team_name}_rank.csv')
    print("불러오기")
    team_df.columns = ['date', 'teamname', 'rank', 'totalgames', 'win', 'loss', 'draw', 'winningrate', 'gamesbehind', 'tengamesrecord', 'streak', 'home', 'away']
    print("컬럼변경")
    team_df.date = pd.to_datetime(team_df.date)
    print("날짜변경")
    result_df = team_df[(team_df.date.dt.year == int(select_year)) & (team_df.date.dt.month == int(select_month))]
    print("날짜변경2")
    # result_df.loc[:, '날짜'] = result_df.날짜.astype(str)
    result_df.date = result_df.date.astype(str)

    response = {}

    response['month_rank'] = []
    response['information'] = []

    for i,j in zip(result_df.to_dict()['date'].values(), result_df.to_dict()['rank'].values()) :
        result_dict = {
            'date' : i,
            'rank' : j
        }
        response['month_rank'].append(result_dict)

    for index in result_df.index :
        response['information'].append(result_df.loc[index, ['date', 'totalgames', 'win', 'loss', 'draw', 'winningrate', 'gamesbehind', 'tengamesrecord', 'streak', 'home', 'away']].to_dict())

    # return
    return json.dumps(response, ensure_ascii=False).encode('utf-8')

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
