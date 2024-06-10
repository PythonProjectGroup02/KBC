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
    
    var body: some View {
        Map(position: $center, content: {
            
            Marker("잠실구장", systemImage: "mappin.and.ellipse", coordinate: .jamsilMaker)
            Marker("고척 스카이돔", systemImage: "mappin.and.ellipse", coordinate: .kiwoomMaker)
            Marker("인천 랜더스 필드", systemImage: "mappin.and.ellipse", coordinate: .ssgMaker)
            Marker("광주 챔피언스 필드", systemImage: "mappin.and.ellipse", coordinate: .kiaMaker)
            Marker("부산 사직구장", systemImage: "mappin.and.ellipse", coordinate: .lotteMaker)
            Marker("대구 라이온즈 파크", systemImage: "mappin.and.ellipse", coordinate: .samsungMaker)
            Marker("대전 이글스 파크", systemImage: "mappin.and.ellipse", coordinate: .hanhwaMaker)
            Marker("창원 NC 파크", systemImage: "mappin.and.ellipse", coordinate: .ncMaker)
            Marker("수원 위즈 파크", systemImage: "mappin.and.ellipse", coordinate: .ktMaker)
        })
    }
}

extension CLLocationCoordinate2D {
    static let jamsilMaker = CLLocationCoordinate2D(latitude: 37.512008, longitude: 127.071868)
    static let kiwoomMaker = CLLocationCoordinate2D(latitude: 37.498904, longitude: 126.807069)
    static let ssgMaker = CLLocationCoordinate2D(latitude: 37.497004, longitude: 126.693273)
    static let kiaMaker = CLLocationCoordinate2D(latitude: 35.168049, longitude: 126.888977)
    static let lotteMaker = CLLocationCoordinate2D(latitude: 35.194270, longitude: 129.061493)
    static let samsungMaker = CLLocationCoordinate2D(latitude: 35.841083, longitude: 128.681581)
    static let hanhwaMaker = CLLocationCoordinate2D(latitude: 36.371404, longitude: 127.429058)
    static let ncMaker = CLLocationCoordinate2D(latitude: 35.222516, longitude: 128.582422)
    static let ktMaker = CLLocationCoordinate2D(latitude: 37.299602, longitude: 127.009829)
    

}

#Preview {
    MapPage()
}
