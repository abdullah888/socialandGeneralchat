//
//  MessageViewModel.swift
//  UOapp
//
//  Created by abdullah on 04/10/1443 AH.
//

import SwiftUI
import Firebase

class MessageViewModel: ObservableObject{
    
    @Published var txt = ""
    @Published var user = ""
    @Published var message : [MessageModel] = []
    @Published var Messagedatas = [MessageModel]()
    let ref = Firestore.firestore()
    
    init() {
        readAllMsgs()
     //   GetAllMessage()
    }
    

    
    func readAllMsgs(){

        ref.collection("Message").order(by: "timeStamp", descending: false).addSnapshotListener { (snap, err) in

            if err != nil{
                print(err!.localizedDescription)
                return
            }

            guard let data = snap else{return}

            data.documentChanges.forEach { (doc) in

                // adding when data is added...

                if doc.type == .added{

                    let msg = try! doc.document.data(as: MessageModel.self)

                    DispatchQueue.main.async {
                        self.message.append(msg)
                    }
                }
            }
        }
    }
    
    func GetAllMessage(){
        
        let db = Firestore.firestore()
       
            db.collection("Message").addSnapshotListener { (snap, err) in
                
                if err != nil{
                    
                    print((err?.localizedDescription)!)
                    return
                }
                
                for i in snap!.documentChanges{
                    
                    let id = i.document.documentID
                    let userID = i.document.documentID
                    let Message = i.document.get("Message") as! String
                    let userName = i.document.get("user") as! String
                   // let timeStamp = i.document.get("timeStamp") as! String
                    DispatchQueue.main.async {
                        self.Messagedatas.append(MessageModel(id: id, userID: userID, Message: Message, user: userName, timeStamp: Date()))
                  //  self.message.append(MessageModel( Message: Message, user: userName, timeStamp: Date()))
                    
                    }
           }
        }
    }
    
    
    func UploadMessage(){
        let db = Firestore.firestore()
        Auth.auth().addStateDidChangeListener { auth, user in
        if let id = user?.uid{
        UserApi.GetUser(ID: id) { User in
            db.collection("Message")
                .document()
                .setData(["userID":User.ID!,"Message":self.txt,"user":User.Name!,"timeStamp":Date()]) { (err) in
                    if err != nil{
                        print((err?.localizedDescription)!)
                        return
                           }
                       }
            self.txt = ""
                    }
                }
            }
        }
    
    
    
    
}


