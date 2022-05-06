//
//  ProductModel.swift
//  UOapp
//
//  Created by abdullah on 24/09/1443 AH.
//

import Foundation
import Firebase
import FirebaseFirestore

class ProductModel  :Identifiable {

    var user: UserModel?
    var isAdded: Bool = false
    var id : String?
    var time : Date?
    var detail : String?
    var text : String?
    var image: String?
    var userName: String?
    var userIamge: String?
  
   
    
    init(id : String, time : Date, text : String,detail : String, image : String, userName : String, userIamge : String) {
        self.id = id
        self.time = time
        self.text = text
        self.detail = detail
        self.image = image
        self.userName = userName
        self.userIamge = userIamge
    }
    
    init(Dictionary : [String : AnyObject]) {
        self.id = Dictionary["id"] as? String
        self.time = Dictionary["time"] as? Date
        self.text = Dictionary["text"] as? String
        self.detail = Dictionary["detail"] as? String
        self.image = Dictionary["image"] as? String
        self.userName = Dictionary["userName"] as? String
        self.userIamge = Dictionary["userIamge"] as? String
        
    }
    
    func MakeDictionary()->[String : AnyObject] {
        var D : [String : AnyObject] = [:]
        D["id"] = self.id as AnyObject
        D["time"] = self.time as AnyObject
        D["text"] = self.text as AnyObject
        D["detail"] = self.detail as AnyObject
        D["image"] = self.image as AnyObject
        D["userName"] = self.userName as AnyObject
        D["userIamge"] = self.userIamge as AnyObject
        return D
    }
    
    func Upload(){
        guard let id = self.id else { return }
        Firestore.firestore().collection("Products").document(id).setData(MakeDictionary())
    }
    
    func Remove(){
        guard let id = self.id else { return }
        Firestore.firestore().collection("Products").document(id).delete()
        
       // Firestore.firestore().collection("Products").document(id).delete()
    }
    
    
}


class ProductsApi {

    static func GetProducts(id : String, completion : @escaping (_ Products : ProductModel)->()){
        Firestore.firestore().collection("Products").document(id).addSnapshotListener { (Snapshot : DocumentSnapshot?, Error : Error?) in
            if let data = Snapshot?.data() as [String : AnyObject]? {
                let New = ProductModel(Dictionary: data)
                completion(New)
            }
        }
    }
    
    static func GetAllProducts(completion : @escaping (_ Products : ProductModel)->()){
        Firestore.firestore().collection("Products").getDocuments { (Snapshot, error) in
            if error != nil { print("Error") ; return }
            guard let documents = Snapshot?.documents else { return }
            for P in documents {
                if let data = P.data() as [String : AnyObject]? {
                    let New = ProductModel(Dictionary: data)
                    completion(New)
                }
            }
        }

    }
    
}

