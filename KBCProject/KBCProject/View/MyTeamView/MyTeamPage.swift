//
//  MyTeamPage.swift
//  KBCProject
//
//  Created by 김소리 on 6/12/24.
//

import SwiftUI

struct MyTeamPage: View {
    @State var myTeam: String = "한화"
    @State var teamhomepage: String = "https://www.naver.com"
    @State var ticketpage: String = "https://www.naver.com"
    @State var mdpage: String = "https://www.naver.com"

    var body: some View {
        VStack(content: {
            Image("\(myTeam)")
                .resizable()
                .frame(width: 200, height: 150)
            HStack(content:{
                Link("팀 홈페이지", destination: URL(string: teamhomepage)!)
                    .foregroundColor(.black)
                Divider()
                Link("티켓팅 페이지", destination: URL(string: ticketpage)!)
                    .foregroundColor(.black)
                Divider()
                Link("MD 구매", destination: URL(string: mdpage)!)
                    .foregroundColor(.black)
            })
            .frame(height: 50)
        })
        .onAppear{
            searchMyTeam()
            teamInfo()
            
        }
    }
    func searchMyTeam(){
        let query = TeamVM()
        myTeam = query.queryDB()
    }
    func teamInfo(){
        switch myTeam{
        case "롯데" :
            teamhomepage = "https://www.giantsclub.com/html/"
            ticketpage = "https://www.giantsclub.com/html/"
            mdpage = "https://www.lottegiantsshop.com/"
        case "한화" :
            teamhomepage = "https://www.hanwhaeagles.co.kr/index.do"
            ticketpage = "https://www.ticketlink.co.kr/sports/baseball/63#reservation"
            mdpage = "https://eaglesshop.kr/"
        case "삼성" :
            teamhomepage = "https://www.samsunglions.com/index.asp"
            ticketpage = "https://www.ticketlink.co.kr/sports/baseball/57#reservation"
            mdpage = "https://samsunglionsmall.com/"
        case "SSG" :
            teamhomepage = "https://www.ssglanders.com/main"
            ticketpage = "https://www.ticketlink.co.kr/sports/baseball/476#reservation"
            mdpage = "https://store.ssglanders.com/"
        case "기아" :
            teamhomepage = "https://tigers.co.kr/"
            ticketpage = "https://www.ticketlink.co.kr/sports/baseball/63#reservation"
            mdpage = "https://teamstore.tigers.co.kr/"
        case "키움" :
            teamhomepage = "https://heroesbaseball.co.kr/index.do"
            ticketpage = "https://ticket.interpark.com/Contents/Sports/GoodsInfo?SportsCode=07001&TeamCode=PB003"
            mdpage = "https://ticket.interpark.com/contents/Promotion/MDShopList?dispNo=001780002001"
        case "NC" :
            teamhomepage = "https://www.ncdinos.com/"
            ticketpage = "https://www.ticketlink.co.kr/sports/baseball/63#reservation"
            mdpage = "https://shop.ncdinos.com/"
        case "LG" :
            teamhomepage = "https://www.lgtwins.com/service/html.ncd?view=/pc_twins/twins_main/twins_main"
            ticketpage = "https://www.ticketlink.co.kr/sports/baseball/59#reservation"
            mdpage = "https://ticket.interpark.com/contents/Promotion/Event/MDShopList?dispNo=001780002003"
        case "두산" :
            teamhomepage = "https://www.doosanbears.com/"
            ticketpage = "https://ticket.interpark.com/Contents/Sports/GoodsInfo?SportsCode=07001&TeamCode=PB004"
            mdpage = "https://ticket.interpark.com/contents/Promotion/Event/MDShopList?dispNo=001780002008"
        case "KT" :
            teamhomepage = "https://www.ktwiz.co.kr/"
            ticketpage = "https://www.ticketlink.co.kr/sports/baseball/62#reservation"
            mdpage = "https://www.ktwizstore.co.kr/"
        default :
            teamhomepage = ""
            
        }
    }
}

#Preview {
    MyTeamPage()
}
