//
//  MessageModel.swift
//  UOapp
//
//  Created by abdullah on 04/10/1443 AH.
//

import SwiftUI
import FirebaseFirestoreSwift

// For Onchange...
struct MessageModel: Codable,Identifiable,Hashable {
    
    @DocumentID var id : String?
    var userID : String
    var Message : String
    var user : String
    var timeStamp: Date
    
    enum CodingKeys: String,CodingKey {
        case id
        case userID
        case Message
        case user
        case timeStamp
    }
}
