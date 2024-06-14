# -*- coding: utf-8 -*-
"""
author:
Description: KBC Crowd Predict
http://localhost:5000/
"""

# 라이브러리
from flask import Flask, jsonify, request
import joblib
import numpy as np
import holidays
import datetime
import pandas as pd

# Flask 정의
app = Flask(__name__)
app.config['JSON_AS_ASCII'] = False # for utf8

# kiwoom
@app.route("/kiwoom")
def predict():
    # 데이터 받기
    month=int(request.args.get("월"))
    day=int(request.args.get("일"))
    # rank=int(request.args.get("순위"))
    away=request.args.get("원정팀")

    date = datetime.date(2024, month, day)
    dateWeek = date.weekday()


    # df = pd.read_csv(f"./Data/rank/{home}_rank.csv")
    df = pd.read_csv("./Data/rank/day_rank.csv")
    rank = df[df.팀명 == '키움'].순위.values[0]
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
    clf = joblib.load("./Data/predict_model/svm_kiwoom.h5")
    thiss = np.array(
        [
            [holiday,hmlRank,hlRank,daybyday]
        ]
    )
    pre = clf.predict(thiss)
    print(pre)
    return jsonify([{'result':pre[0]}])


if __name__ == "__main__":
    app.run(host="127.0.0.1", port=5000, debug=True)