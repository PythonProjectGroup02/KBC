//
//  CustomNavigationBar.swift
//  KBCProject
//
//  Created by lcy on 6/12/24.
//

import SwiftUI

struct CustomNavigationBar: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var titleName: String
    @State var backButton: Bool
    
    var body: some View {
        ZStack(content: {
            if backButton {
                HStack(content: {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                        dismiss.callAsFunction()
                    }, label: {
                        HStack(content: {
                            Image(systemName: "arrowtriangle.backward.fill")
                                .foregroundStyle(Color.white)
                            
                            Text("뒤로 가기")
                                .foregroundStyle(Color.white)
                                .bold()
                        })
                        .frame(width: UIScreen.main.bounds.width / 4, alignment: .trailing)
                    })
                    
                    Text("")
                        .frame(width: (UIScreen.main.bounds.width / 4) * 3, alignment: .leading)
                })
            }
            
            Text(titleName)
                .font(.title)
                .bold()
                .foregroundStyle(Color.white)
                .frame(width: UIScreen.main.bounds.width)
        })
        .ignoresSafeArea()
        .frame(width: UIScreen.main.bounds.width, height: 50)
        .background(Color(red: 0.057, green: 0.139, blue: 0.328))
        
    } // body
}

#Preview {
    CustomNavigationBar(titleName: "KBC", backButton: false)
}
