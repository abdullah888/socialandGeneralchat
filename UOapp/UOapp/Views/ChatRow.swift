//
//  ChatRow.swift
//  UOapp
//
//  Created by abdullah on 04/10/1443 AH.
//

import SwiftUI
import SDWebImageSwiftUI
struct ChatRow: View {
    @StateObject var ProfileData = ProfileViewModel()
    var chatData : MessageModel
  
    var body: some View {
        
        HStack(spacing: 15){
            
            // NickName View...
            
            if chatData.user != ProfileData.userInfo.Name!{
                
                NickName(name: chatData.user)
            }
            
            if chatData.user == ProfileData.userInfo.Name!{Spacer(minLength: 0)}
            
            VStack(alignment: chatData.user == ProfileData.userInfo.Name! ? .trailing : .leading, spacing: 5, content: {
                
                Text(chatData.Message)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .padding()
                    .background(.red.opacity(0.3))
                // Custom Shape...
                    .clipShape(ChatBubble(myMsg: chatData.user == ProfileData.userInfo.Name!))
                
                Text(chatData.timeStamp,style: .time)
                    .font(.caption2)
                    .foregroundColor(.gray)
                    .padding(chatData.user != ProfileData.userInfo.Name! ? .leading : .trailing , 10)
            })
            
            if chatData.user == ProfileData.userInfo.Name!{
                
                NickName(name: chatData.user)
            }
            
            if chatData.user != ProfileData.userInfo.Name!{Spacer(minLength: 0)}
        }
        .padding(.horizontal)
        // For SCroll Reader....
        .id(chatData.id)
    }
}





struct NickName : View {
    @StateObject var ProfileData = ProfileViewModel()
    var name : String
 
    
    var body: some View{
        
        Text(String(name.first!))
            .fontWeight(.heavy)
            .foregroundColor(.white)
            .frame(width: 50, height: 50)
            .background((name == ProfileData.userInfo.Name! ? Color.blue : Color.green).opacity(0.5))
            .clipShape(Circle())
            // COntext menu For Name Display...
            .contentShape(Circle())
            .contextMenu{
                
                Text(name)
                    .fontWeight(.bold)
            }
    }
}
