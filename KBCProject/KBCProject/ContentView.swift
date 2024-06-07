//
//  ContentView.swift
//  KBCProject
//
//  Created by 김소리 on 6/5/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Text("ssibal")
                .font(.custom("KBO_bold", size: 30))
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
