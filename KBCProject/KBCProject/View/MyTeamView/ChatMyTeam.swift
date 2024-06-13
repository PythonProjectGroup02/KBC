//
//  ChatMyTeam.swift
//  KBCProject
//
//  Created by lcy on 6/13/24.
//

import SwiftUI

struct Chatting {
    let id: String
    let text: String
}

extension Chatting: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct ChatMyTeam: View {
    
    @State var chatData = [
        Chatting(id: "1", text: "ㅋㅋ"),
        Chatting(id: "2", text: "ㅋㅋ111"),
        Chatting(id: "3", text: "ㅋㅋ3333"),
        Chatting(id: "4", text: "ㅋㅋ3333"),
        Chatting(id: "5", text: "ㅋㅋ3333"),
        Chatting(id: "6", text: "ㅋㅋ3333"),
        Chatting(id: "7", text: "ㅋㅋ3333"),
        Chatting(id: "8", text: "ㅋㅋ3333"),
        Chatting(id: "9", text: "ㅋㅋ3333"),
        Chatting(id: "10", text: "ㅋㅋ3333"),
        Chatting(id: "11", text: "ㅋㅋ3333"),
        Chatting(id: "12", text: "ㅋㅋ3333"),
    ]
    
    @State var tfID: String = ""
    @State var tfText: String = ""
    
    var body: some View {
        VStack(content: {
            
            CustomNavigationBar(titleName: "팀 응원", backButton: true)
            
            ScrollView(content: {
                List(chatData, id: \.self, rowContent: { chat in
                    ChatViewCell(chat: chat)
                })
                .padding()
                .listStyle(.plain)
                .frame(height: UIScreen.main.bounds.height / 3)
                
                Divider()
                
                VStack(content: {
                    HStack(content: {
                        Text("응원 남기기")
                            .font(.largeTitle)
                            .padding([.leading, .top], 20)
                        
                        Spacer()
                    })
                                    
    //                HStack(content: {
                        TextField("", text: $tfText)
                        .frame(width: (UIScreen.main.bounds.width / 3) * 2)
    //                        .border(Color.black)
                            .textFieldStyle(.roundedBorder)
                            .padding()
    //                })
                    
                    Button("전송", action: {
                        
                    })
                    .frame(width: 80, height: 40)
                    .background(Color.blue)
                    .foregroundStyle(Color.white)
                    .clipShape(.rect(cornerRadius: 10))
                    .font(.system(size: 22))
                    
                }) // 응원 VStack
                
                Spacer()
            })
            Spacer()
        })
        .navigationBarBackButtonHidden(true)
    }
}

struct ChatViewCell: View {
    @State var chat: Chatting
    var body: some View {
        HStack(content: {
            Text(chat.id)
            Text(chat.text)
        })
    }
}

#Preview {
    ChatMyTeam()
}
