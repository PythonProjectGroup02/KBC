////
////  CustomTabbar.swift
////  KBCProject
////
////  Created by lcy on 6/12/24.
////
//
//import SwiftUI
//
//struct CustomTabbar: View {
//    
//    // Custom
//    @State var activeTap: TabItem = .main
//    @State var allTaps: [AnimatedTap] = TabItem.allCases.compactMap { tab -> AnimatedTap? in
//        return .init(tab: tab)
//    }
//    
//    var body: some View {
//        VStack(content: {
//          CustomNavigationBar(titleName: "KBC", backButton: false)
//            Spacer()
//            
//            HStack(content: {
//                ForEach($allTaps) { $animatedTab in
//                    let aniTap = animatedTab.tab
//                    
//                    VStack(spacing:4, content: {
//                        Image(systemName: aniTap.rawValue)
//                            .font(.title2)
//                            .symbolEffect(.bounce.up.byLayer, value: animatedTab.isAnimating)
//                        
//                        Text("\(aniTap.title)")
//                            .font(.caption2)
//                            .textScale(.secondary)
//                    })
//                    .ignoresSafeArea()
//                    .frame(maxWidth: .infinity)
//                    .foregroundStyle(activeTap == aniTap ? Color.primary : Color.gray.opacity(0.7))
//                    .padding(.top, 15)
//                    .contentShape(.rect)
//                    .onTapGesture(perform: {
//                        withAnimation(.bouncy, completionCriteria: .logicallyComplete, {
//                            activeTap = aniTap
//                            animatedTab.isAnimating = true
//                        }, completion : {
//                            var transaction = Transaction()
//                            transaction.disablesAnimations = true
//                            withTransaction(transaction) {
//                                animatedTab.isAnimating = nil
//                            }
//                        })
//                    })
//                    
//                }
//            }) // HStack
//            .background(.bar)
//        })
////        TabView(selection: $activeTap, content: {
////            NavigationStack {
////                MainPage()
////            }
////            .setUpTab(.main)
////            
////            NavigationStack {
////                ScoreNavigation()
////            }
////            .setUpTab(.score)
////            
//////            NavigationStack {
//////                MyTeamPage()
//////            }
//////            .setUpTab(.baseball)
////            
////            NavigationStack {
////                MapPage()
////            }
////            .setUpTab(.map)
//            
////        }) // TabView
////        
////        switch activeTap {
////        case .main:
////            MainPage()
////        case .score:
////            ScoreNavigation()
////        case .baseball:
////            MyTeamPage()
////        case .map:
////            MapPage()
////        }
////        
////        Spacer()
////        CustomTabBar()
//    }
//    
//    @ViewBuilder
//    func CustomTabBar() -> some View {
//        HStack(content: {
//            ForEach($allTaps) { $animatedTab in
//                let aniTap = animatedTab.tab
//                
//                VStack(spacing:4, content: {
//                    Image(systemName: aniTap.rawValue)
//                        .font(.title2)
//                        .symbolEffect(.bounce.up.byLayer, value: animatedTab.isAnimating)
//                    
//                    Text("\(aniTap.title)")
//                        .font(.caption2)
//                        .textScale(.secondary)
//                })
//                .ignoresSafeArea()
//                .frame(maxWidth: .infinity)
//                .foregroundStyle(activeTap == aniTap ? Color.primary : Color.gray.opacity(0.7))
//                .padding(.top, 15)
//                .contentShape(.rect)
//                .onTapGesture(perform: {
//                    withAnimation(.bouncy, completionCriteria: .logicallyComplete, {
//                        activeTap = aniTap
//                        animatedTab.isAnimating = true
//                    }, completion : {
//                        var transaction = Transaction()
//                        transaction.disablesAnimations = true
//                        withTransaction(transaction) {
//                            animatedTab.isAnimating = nil
//                        }
//                    })
//                })
//                
//            }
//        }) // HStack
//        .background(.bar)
//    }
//}
//
//
//struct AnimatedTap: Identifiable {
//    var id = UUID()
//    var tab: TabItem
//    var isAnimating: Bool?
//}
//
////enum TabItem: String, CaseIterable {
////    case main = "house.fill"
////    case score = "flag.2.crossed.fill"
////    case baseball = "baseball.fill"
////    case map = "map.fill"
////    
////    var title: String {
////        switch self {
////        case .main:
////            return "Main"
////        case .score:
////            return "Score"
////        case .baseball:
////            return "Baseball"
////        case .map:
////            return "Map"
////        }
////    }
////}
//
//extension View {
//    @ViewBuilder
//    func setUpTab(_ tab: TabItem) -> some View {
//        self
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .tag(tab)
//            .toolbar(.hidden, for: .tabBar)
//    }
//}
//
//#Preview {
//    CustomTabbar()
//}
