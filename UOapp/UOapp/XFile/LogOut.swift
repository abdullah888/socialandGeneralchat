//
//  LogOut.swift
//  UOapp
//
//  Created by abdullah on 29/09/1443 AH.
//

import SwiftUI
import Firebase

struct LogOut: View {
    var body: some View{
        
        VStack{
            Text("Logged successfully")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.black.opacity(0.7))
            
            Button(action: {
                
                try! Auth.auth().signOut()
                UserDefaults.standard.set(false, forKey: "status")
                NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                
            }) {
                Text("Log out")
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 50)
            }
            .background(.black)
            .cornerRadius(8)
            .padding(.top, 25)
            
        }
        
    }
}

struct LogOut_Previews: PreviewProvider {
    static var previews: some View {
        LogOut()
    }
}
