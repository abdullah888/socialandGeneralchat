//
//  ProductViewModel.swift
//  UOapp
//
//  Created by abdullah on 24/09/1443 AH.
//


//
//import SwiftUI
//import Firebase
//
//class ProductViewModel :ObservableObject{
//
//    @Published var products: [ProductModel] = []
//    @Published var Productdatas = [ProductModel]()
//    // product
//    @Published var text = ""
//    @Published var detail = ""
//    // Image Picker...
//    @Published var picker = false
//    @Published var img_Data = Data(count: 0)
//
//
//    init(){
//
//        GetProducts()
//
//    }
//
//
//    func UploadProduct(){
////        let Productid : String = self.products.id? ?? UUID().uuidString
//        let ProductsID = UUID().uuidString
//        Auth.auth().addStateDidChangeListener { auth, user in
//        if let id = user?.uid{
//        UserApi.GetUser(ID: id) { User in
//            UploadImage(imageData: self.img_Data, path: "Products_Image") { url in
//                ProductModel(id: ProductsID, time: Date(), text: self.text, detail: self.detail, image: url, userName: User.Name!, userIamge: User.UserImage!).Upload()
//                     }
//                }
//            }
//        }
//    }
//
//    func GetProducts(){
//        ProductsApi.GetAllProducts { Products in
//            self.Productdatas.append(Products)
//
//        }
//    }
//
//  func GetData(){
//      ProductsApi.GetAllProducts { Products in
//          self.products.append(Products)
//      }
//    }
//
//
//
//}




import SwiftUI
import Firebase

class ProductViewModel :ObservableObject{
    
    @Published var products: [ProductModel] = []
    @Published var Productdatas = [ProductModel]()
    
    // product
    @Published var text = ""
    @Published var detail = ""
    // Image Picker...
    @Published var picker = false
    @Published var img_Data = Data(count: 0)
    @Published var isLoading = false
    
    init(){
        
        GetAllProduct()
    }
    
    
    func UploadProduct(){
        let db = Firestore.firestore()
        Auth.auth().addStateDidChangeListener { auth, user in
        if let id = user?.uid{
        UserApi.GetUser(ID: id) { User in
        UploadImage(imageData: self.img_Data, path: "Products_Image") { url in
            db.collection("Products")
                .document()
                .setData(["text":self.text,"detail":self.detail,"image":url,"userName":User.Name!,"userIamge":User.UserImage!]) { (err) in
                    if err != nil{
                        print((err?.localizedDescription)!)
                        return
                           }
                       }
                    }
                }
            }
        }
    }
 
    func GetAllProduct(){
        
        let db = Firestore.firestore()
       
            db.collection("Products").addSnapshotListener { (snap, err) in
                
                if err != nil{
                    
                    print((err?.localizedDescription)!)
                    return
                }
                
                for i in snap!.documentChanges{
                    
                    let id = i.document.documentID
                    let text = i.document.get("text") as! String
                    let detail = i.document.get("detail") as! String
                    let image = i.document.get("image") as! String
                    let userName = i.document.get("userName") as! String
                    let userIamge = i.document.get("userIamge") as! String
                    self.Productdatas.append(ProductModel(id: id, time: Date(), text: text, detail: detail, image: image, userName: userName, userIamge: userIamge))
               
           }
        }
    }
    
    
}
