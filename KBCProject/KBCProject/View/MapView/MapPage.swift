//
//  MapPage.swift
//  KBCProject
//
//  Created by 김소리 on 6/7/24.
//

import SwiftUI
import MapKit

struct MapPage: View {
    @State var center = MapCameraPosition.region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 36.654899, longitude: 127.928812),
        span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 2)))
    var teamInfo = [
        ("구장을 선택해주세요", CLLocationCoordinate2D(latitude: 36.654899, longitude: 127.928812)),
        ("서울종합운동장 야구장", CLLocationCoordinate2D.jamsilMarker),
        ("고척 스카이돔", CLLocationCoordinate2D.kiwoomMarker),
        ("인천 SSG 랜더스필드", CLLocationCoordinate2D.ssgMarker),
        ("광주-기아 챔피언스 필드", CLLocationCoordinate2D.kiaMarker),
        ("사직 야구장", CLLocationCoordinate2D.lotteMarker),
        ("대구 삼성 라이온즈 파크", CLLocationCoordinate2D.samsungMarker),
        ("대전 한화생명 이글스파크", CLLocationCoordinate2D.hanhwaMarker),
        ("창원 NC 파크", CLLocationCoordinate2D.ncMarker),
        ("수원 케이티 위즈 파크", CLLocationCoordinate2D.ktMarker)
    ]
    @State var team = "구장을 선택해주세요"
    @State var mapheight = 600
    
    var body: some View {
        VStack {
            CustomNavigationBar(titleName: "KBC", backButton: false)
            Spacer()
            Picker("", selection: $team) {
                ForEach(teamInfo.map { $0.0 }, id: \.self) {
                    Text($0)
                }
            }
            .onChange(of: team) {
                selectTeam()
            }
            Map(position: $center) {
                ForEach(teamInfo.dropFirst(), id: \.0) { team in
                    Marker(team.0, systemImage: "mappin.and.ellipse", coordinate: team.1)
                }
            }
            .frame(height: CGFloat(mapheight))
            
            info
            Spacer()
        }
    }
    
    @ViewBuilder
    var info: some View {
        switch team {
        case "서울종합운동장 야구장":
            stadiumInfo(teamImages: ["LG", "두산"], stadiumName: "서울종합운동장 야구장", teams: "LG 트윈스, 두산 베어스", address: "서울특별시 송파구 올림픽로 25 (잠실동)", capacity: "23,750석")
        case "고척 스카이돔":
            stadiumInfo(teamImages: ["키움"], stadiumName: "고척 스카이돔", teams: "키움 히어로즈", address: "서울특별시 구로구 경인로 430 (고척동)", capacity: "16,000석 (최대 16,744명 수용)")
        case "인천 SSG 랜더스필드":
            stadiumInfo(teamImages: ["SSG"], stadiumName: "인천 SSG 랜더스필드", teams: "SSG 랜더스", address: "인천광역시 미추홀구 매소홀로 618 (문학동)", capacity: "23,000석")
        case "대구 삼성 라이온즈 파크":
            stadiumInfo(teamImages: ["삼성"], stadiumName: "대구 삼성 라이온즈 파크", teams: "삼성 라이온즈", address: "대구광역시 수성구 야구전설로 1 (연호동)", capacity: "24,000석")
        case "대전 한화생명 이글스파크":
            stadiumInfo(teamImages: ["한화"], stadiumName: "대전 한화생명 이글스파크", teams: "한화 이글스", address: "대전광역시 중구 대종로 373 (부사동)", capacity: "13,000석")
        case "사직 야구장":
            stadiumInfo(teamImages: ["롯데"], stadiumName: "사직 야구장", teams: "롯데 자이언츠", address: "부산광역시 동래구 사직로 45 (사직동)", capacity: "22,758석")
        case "창원 NC 파크":
            stadiumInfo(teamImages: ["NC"], stadiumName: "창원 NC 파크", teams: "NC 다이노스", address: "경상남도 창원시 마산회원구 삼호로 63 (양덕동)", capacity: "17,891석")
        case "광주-기아 챔피언스 필드":
            stadiumInfo(teamImages: ["KIA"], stadiumName: "광주-기아 챔피언스 필드", teams: "기아 타이거즈", address: "광주광역시 북구 서림로 10 (임동)", capacity: "20,500석")
        case "수원 케이티 위즈 파크":
            stadiumInfo(teamImages: ["KT"], stadiumName: "수원 케이티 위즈 파크", teams: "KT 위즈", address: "경기도 수원시 장안구 경수대로 893 (조원동)", capacity: "18,700석")
        default:
            Text("")
                .hidden()
        }
    }
    
    func stadiumInfo(teamImages: [String], stadiumName: String, teams: String, address: String, capacity: String) -> some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                ForEach(teamImages, id: \.self) { image in
                    Image(image)
                        .resizable()
                        .frame(width: 70, height: 60)
                    Spacer()
                }
            }
            Spacer()
            Text(stadiumName)
                .bold()
                .font(.system(size: 20))
            Spacer()
            Text("사용 구단 : \(teams)")
            Spacer()
            Text("주소 : \(address)")
            Spacer()
            Text("좌석 규모 : \(capacity)")
            Spacer()
        }
    }
    
    func selectTeam() {
        if team == "구장을 선택해주세요" {
            center = .region(MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 36.654899, longitude: 127.928812),
                span: MKCoordinateSpan(latitudeDelta: 2, longitudeDelta: 2)
            ))
            mapheight = 600
        } else if let selectedTeam = teamInfo.first(where: { $0.0 == team }) {
            center = .region(MKCoordinateRegion(
                center: selectedTeam.1,
                span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
            ))
            mapheight = 300
        }
    }

}

extension CLLocationCoordinate2D {
    static let jamsilMarker = CLLocationCoordinate2D(latitude: 37.512008, longitude: 127.071868)
    static let kiwoomMarker = CLLocationCoordinate2D(latitude: 37.498901, longitude: 126.867147)
    static let ssgMarker = CLLocationCoordinate2D(latitude: 37.436986, longitude: 126.693329)
    static let kiaMarker = CLLocationCoordinate2D(latitude: 35.168049, longitude: 126.888977)
    static let lotteMarker = CLLocationCoordinate2D(latitude: 35.194270, longitude: 129.061493)
    static let samsungMarker = CLLocationCoordinate2D(latitude: 35.841083, longitude: 128.681581)
    static let hanhwaMarker = CLLocationCoordinate2D(latitude: 36.317153, longitude: 127.429058)
    static let ncMarker = CLLocationCoordinate2D(latitude: 35.222516, longitude: 128.582422)
    static let ktMarker = CLLocationCoordinate2D(latitude: 37.299602, longitude: 127.009829)
}

#Preview {
    MapPage()
}
