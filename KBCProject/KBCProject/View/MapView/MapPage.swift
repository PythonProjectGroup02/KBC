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
    var teamname = ["LG","두산","키움","SSG","삼성","한화","롯데","NC","기아","KT"]
    @State var team = ""
    @State var mapheight = 600
    @State var gudanName = ""
    
    var body: some View {
        VStack(content: {
            Picker("구단을 선택해주세요", selection: $team){
                ForEach(teamname, id: \.self) {
                    Text($0)
                }
            }
            .onChange(of: team, {
                selectTeam()
            })
            Map(position: $center, content: {
                Marker("잠실구장", systemImage: "mappin.and.ellipse", coordinate: .jamsilMarker)
                Marker("고척 스카이돔", systemImage: "mappin.and.ellipse", coordinate: .kiwoomMarker)
                Marker("인천 랜더스 필드", systemImage: "mappin.and.ellipse", coordinate: .ssgMarker)
                Marker("광주 챔피언스 필드", systemImage: "mappin.and.ellipse", coordinate: .kiaMarker)
                Marker("부산 사직구장", systemImage: "mappin.and.ellipse", coordinate: .lotteMarker)
                Marker("대구 라이온즈 파크", systemImage: "mappin.and.ellipse", coordinate: .samsungMarker)
                Marker("대전 이글스 파크", systemImage: "mappin.and.ellipse", coordinate: .hanhwaMarker)
                Marker("창원 NC 파크", systemImage: "mappin.and.ellipse", coordinate: .ncMarker)
                Marker("수원 위즈 파크", systemImage: "mappin.and.ellipse", coordinate: .ktMarker)
            })
            .frame(height: CGFloat(mapheight))
            
            info
        })
    }
    @ViewBuilder
    var info: some View {
        switch team {
        case "LG","두산":
            Image("jamsil")
                .resizable()
                .frame(height: 200)
            Text("서울종합운동장 야구장")
                .bold()
                .font(.system(size: 20))
            Text("사용 구단 : LG 트윈스, 두산 베어스")
            Text("주소 : 서울특별시 송파구 올림픽로 25 (잠실동)")
            Text("좌석 규모 : 23,750석")
        case "키움":
            Text("고척 스카이돔")
            Text("사용 구단 : 키움 히어로즈")
        case "SSG":
            Text("고척 스카이돔")
            Text("사용 구단 : 키움 히어로즈")
        case "삼성":
            Text("고척 스카이돔")
            Text("사용 구단 : 키움 히어로즈")
        case "한화":
            Text("고척 스카이돔")
            Text("사용 구단 : 키움 히어로즈")
        case "롯데":
            Text("고척 스카이돔")
            Text("사용 구단 : 키움 히어로즈")
        case "NC":
            Text("고척 스카이돔")
            Text("사용 구단 : 키움 히어로즈")
        case "기아":
            Text("고척 스카이돔")
            Text("사용 구단 : 키움 히어로즈")
        case "KT":
            Text("고척 스카이돔")
            Text("사용 구단 : 키움 히어로즈")
        default:
            Text("")
                .hidden()
        }
    }
    
    func selectTeam(){
        switch team {
        case "LG","두산":
            center = .region(MKCoordinateRegion(center: .jamsilMarker, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)))
            mapheight = 200
        case "키움":
            center = .region(MKCoordinateRegion(center: .kiwoomMarker, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)))
            mapheight = 300
        case "SSG":
            center = .region(MKCoordinateRegion(center: .ssgMarker, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)))
            mapheight = 300
        case "삼성":
            center = .region(MKCoordinateRegion(center: .samsungMarker, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)))
            mapheight = 300
        case "한화":
            center = .region(MKCoordinateRegion(center: .hanhwaMarker, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)))
            mapheight = 300
        case "롯데":
            center = .region(MKCoordinateRegion(center: .lotteMarker, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)))
            mapheight = 300
        case "NC":
            center = .region(MKCoordinateRegion(center: .ncMarker, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)))
            mapheight = 300
        case "기아":
            center = .region(MKCoordinateRegion(center: .kiaMarker, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)))
            mapheight = 300
        case "KT":
            center = .region(MKCoordinateRegion(center: .ktMarker, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)))
            mapheight = 300
        default:
            center = .region(MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 36.654899, longitude: 127.928812),
                span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 2)))
            mapheight = 600
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
