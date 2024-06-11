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
    var teamname = ["구단을 선택해주세요","LG","두산","키움","SSG","삼성","한화","롯데","NC","기아","KT"]
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
            VStack(content: {
                Spacer()
                HStack(content: {
                    Spacer()
                    Image("LG")
                        .resizable()
                        .frame(width: 70, height:60)
                    Spacer()
                    Image("두산")
                        .resizable()
                        .frame(width: 70, height:60)
                    Spacer()
                })
                Spacer()
                Text("서울종합운동장 야구장")
                    .bold()
                    .font(.system(size: 20))
                Spacer()
                Text("사용 구단 : LG 트윈스, 두산 베어스")
                Spacer()
                Text("주소 : 서울특별시 송파구 올림픽로 25 (잠실동)")
                Spacer()
                Text("좌석 규모 : 23,750석")
                Spacer()
            })
            
        case "키움":
            Spacer()
            Image("키움")
                .resizable()
                .frame(width: 70, height:60)
            Spacer()
            Text("고척 스카이돔")
                .bold()
                .font(.system(size: 20))
            Spacer()
            Text("사용 구단 : 키움 히어로즈")
            Spacer()
            Text("주소 : 서울특별시 구로구 경인로 430 (고척동)")
            Spacer()
            Text("좌석 규모 : 16,000석 (최대 16,744명 수용)")
            Spacer()
            
        case "SSG":
            Spacer()
            Image("SSG")
                .resizable()
                .frame(width: 70, height:60)
            Spacer()
            Text("인천 SSG 랜더스필드")
                .bold()
                .font(.system(size: 20))
            Spacer()
            Text("사용 구단 : SSG 랜더스")
            Spacer()
            Text("주소 : 인천광역시 미추홀구 매소홀로 618 (문학동)")
            Spacer()
            Text("좌석 규모 : 23,000석")
            Spacer()
        case "삼성":
            Spacer()
            Image("삼성")
                .resizable()
                .frame(width: 70, height:60)
            Spacer()
            Text("대구 삼성 라이온즈 파크")
                .bold()
                .font(.system(size: 20))
            Spacer()
            Text("사용 구단 : 삼성 라이온즈")
            Spacer()
            Text("주소 : 대구광역시 수성구 야구전설로 1 (연호동)")
            Spacer()
            Text("좌석 규모 : 24,000석")
            Spacer()
        case "한화":
            Spacer()
            Image("한화")
                .resizable()
                .frame(width: 70, height:60)
            Spacer()
            Text("대전 한화생명 이글스파크")
                .bold()
                .font(.system(size: 20))
            Spacer()
            Text("사용 구단 : 한화 이글스")
            Spacer()
            Text("주소 : 대전광역시 중구 대종로 373 (부사동)")
            Spacer()
            Text("좌석 규모 : 13,000석")
            Spacer()
        case "롯데":
            Spacer()
            Image("롯데")
                .resizable()
                .frame(width: 70, height:60)
            Spacer()
            Text("사직 야구장")
                .bold()
                .font(.system(size: 20))
            Spacer()
            Text("사용 구단 : 롯데 자이언츠")
            Spacer()
            Text("주소 : 부산광역시 동래구 사직로 45 (사직동)")
            Spacer()
            Text("좌석 규모 : 22,758석")
            Spacer()
        case "NC":
            Spacer()
            Image("NC")
                .resizable()
                .frame(width: 70, height:60)
            Spacer()
            Text("창원 NC 파크")
                .bold()
                .font(.system(size: 20))
            Spacer()
            Text("사용 구단 : NC 다이노스")
            Spacer()
            Text("주소 : 경상남도 창원시 마산회원구 삼호로 63 (양덕동)")
            Spacer()
            Text("좌석 규모 : 17,891석")
            Spacer()
        case "기아":
            Spacer()
            Image("기아")
                .resizable()
                .frame(width: 70, height:60)
            Spacer()
            Text("광주-기아 챔피언스 필드")
                .bold()
                .font(.system(size: 20))
            Spacer()
            Text("사용 구단 : 기아 타이거즈")
            Spacer()
            Text("주소 : 광주광역시 북구 서림로 10 (임동)")
            Spacer()
            Text("좌석 규모 : 20,500석")
            Spacer()
        case "KT":
            Spacer()
            Image("KT")
                .resizable()
                .frame(width: 70, height:60)
            Spacer()
            Text("수원 케이티 위즈 파크")
                .bold()
                .font(.system(size: 20))
            Spacer()
            Text("사용 구단 : KT 위즈")
            Spacer()
            Text("주소 : 경기도 수원시 장안구 경수대로 893 (조원동)")
            Spacer()
            Text("좌석 규모 : 18,700석")
            Spacer()
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
            center = .region(MKCoordinateRegion(center: .kiwoomMarker, span: MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008)))
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
                span: MKCoordinateSpan(latitudeDelta: 2, longitudeDelta: 0.5)))
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
