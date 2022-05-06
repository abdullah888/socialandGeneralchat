//
//  Chat.swift
//  UOapp
//
//  Created by abdullah on 04/10/1443 AH.
//

import SwiftUI

struct Chat: View {
    @StateObject var ChatData = MessageViewModel()
   
    @State var scrolled = false
    var body: some View {
        
        VStack(spacing: 0){
            
            HStack{
                
                Text("صفحة المحادثات")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                
                Spacer(minLength: 0)
            }
            .padding()
            .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
            .background(.white)
            
            ScrollViewReader{reader in
                
                ScrollView{
                    
                    VStack(spacing: 15){
                        
                        ForEach(ChatData.message){msg in
                            
                            ChatRow(chatData: msg)
                            .onAppear{
                                // First Time Scroll
                                if msg.id == self.ChatData.message.last!.id && !scrolled{
                                    
                                    reader.scrollTo(ChatData.message.last!.id,anchor: .bottom)
                                    scrolled = true
                                }
                            }
                        }
                        .onChange(of: ChatData.message, perform: { value in
                            
                            // You can restrict only for current user scroll....
                            reader.scrollTo(ChatData.message.last!.id,anchor: .bottom)
                        })
                    }
                    .padding(.vertical)
                }
            }
            
            HStack(spacing: 15){
                
                TextField("Enter Message", text: $ChatData.txt)
                    .padding(.horizontal)
                    // Fixed Height For Animation...
                    .frame(height: 45)
                    .background(Color.primary.opacity(0.06))
                    .clipShape(Capsule())
                
                if ChatData.txt != ""{
                    
                    Button(action: ChatData.UploadMessage, label: {
                        
                        Image(systemName: "paperplane.fill")
                            .font(.system(size: 22))
                            .foregroundColor(.white)
                            .frame(width: 45, height: 45)
                            .background(.black)
                            .clipShape(Circle())
                    })
                }
            }
            .animation(.default)
            .padding()
        }
      
        .ignoresSafeArea(.all, edges: .top)
    }
}

