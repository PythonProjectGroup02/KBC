//
//  ChatMyTeam.swift
//  KBCProject
//
//  Created by lcy on 6/13/24.
//

import SwiftUI

struct ChatMyTeam: View {
    @State var btnAni: Bool = false
    
    @State var chatData: [ChatModel] = []
    @State var stateCode = 0
    
    @State var tfNickName: String = ""
    @State var tfText: String = ""
    
    @State var insertAlert: Bool = false
    
    var body: some View {
        VStack(content: {
            
            CustomNavigationBar(titleName: "팀 응원", backButton: true)
            
            ScrollView(content: {
                
                VStack(content: {
                    if stateCode != 0 {
                        ScrollView(content: {
                            ForEach(chatData, id: \.id, content: { chat in
                                ChatViewCell(chat: chat)
                            })
                        })
                        .padding()
                    }
                    else {
                        Text("아직 사람들이 응원을 남기지 않았습니다!")
                            .font(.title2)
                    }
                })
                .frame(height: UIScreen.main.bounds.height / 3)
                
                Divider()
                
                VStack(content: {
                    HStack(content: {
                        Text("응원 남기기")
                            .font(.largeTitle)
                            .padding([.leading, .top], 20)
                        
                        Spacer()
                    })
                    
                    VStack(content: {
                        HStack(content: {
                            Text("닉네임")
                                .font(.title3)
                            Spacer()
                        })
                        TextField("", text: $tfNickName)
                        .frame(width: (UIScreen.main.bounds.width / 3) * 2)
    //                        .border(Color.black)
                            .textFieldStyle(.roundedBorder)
//                            .padding()
                    })
                    .frame(width: UIScreen.main.bounds.width / 3 * 2)
                    .padding()
                                    
                    VStack(content: {
                        HStack(content: {
                            Text("글 내용")
                                .font(.title3)
                            Spacer()
                        })
                        TextField("", text: $tfText)
                        .frame(width: (UIScreen.main.bounds.width / 3) * 2)
                            .textFieldStyle(.roundedBorder)
                    })
                    .frame(width: UIScreen.main.bounds.width / 3 * 2)
                    .padding()
                    
                    Button("전송", action: {
                        if checkWord() {
                            return
                        }
                        
                        // MySQL Insert Action
                        Task {
                            insertAlert = try await ChatVM().insertChatContent(chatting: InsertChat(content: tfText, nickname: tfNickName, team: serachMyTeam()))
                            
                            reloadData()
                        }
                    })
                    .frame(width: 80, height: 40)
                    .background(Color.blue)
                    .foregroundStyle(Color.white)
                    .clipShape(.rect(cornerRadius: 10))
                    .font(.system(size: 22))
                    .padding()
                    .alert("확인", isPresented: $insertAlert, actions: {
                        Button("확인", role: .none, action: {
                            tfText = ""
                            tfNickName = ""
                        })
                    }, message: {
                        Text("정상적으로 처리되었습니다.")
                    })
                    
                }) // 응원 VStack
                
                Spacer()
            })
            Spacer()
        })
        .navigationBarBackButtonHidden(true)
        .onAppear(perform: {
            reloadData()
        })
    }
    
    func serachMyTeam() -> String{
        return TeamVM().queryDB()
    }
    
    func reloadData() {
        let chatAPI = ChatVM()
        Task {
            (stateCode, chatData) = try await chatAPI.selectChatContent(team: serachMyTeam())
        }
    }
    
    func checkWord() -> Bool {
        if tfText == "" {
            print("tfText 공백")
            return true
        }
        
        if tfNickName == "" {
            print("tfNickName 공백")
            return true
        }
        
        return false
    }
}

struct ChatViewCell: View {
    @State var btnAni: Bool = false
    @State var chat: ChatModel
    var body: some View {
        GroupBox(label: HStack{
            Text(chat.nickname)
            
            Spacer()
            
            Button(action: {
                btnAni.toggle()
            }, label: {
                Image(systemName: btnAni ? "heart.fill" : "heart")
                    .foregroundStyle(Color.red)
                    .symbolEffect(.bounce.up.wholeSymbol, value: btnAni)
            })
        }, content: {
            VStack(content: {
                
                Divider()
                
                Text(chat.content)
                    .frame(alignment: .leading)
                    .font(.title2)
                    .padding()

//                Text("\(chat.id)")
                
                HStack(content: {
                    Spacer()
                    Text("20"+chat.date)
                })
            })
        })
        .frame(width: UIScreen.main.bounds.width - 20)
    }
}

#Preview {
    ChatMyTeam()
}
