//
//  ProductCell.swift
//  UOapp
//
//  Created by abdullah on 24/09/1443 AH.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct ProductCell: View {
    @State var  darkPink = Color(red: 208 / 255, green: 45 / 255, blue: 208 / 255)
    @StateObject var ProductDate = ProductViewModel()
    @StateObject var profileDate = ProfileViewModel()
    var product : ProductModel
    var body: some View {
        
        VStack {
            
            WebImage(url: URL(string: product.image!))
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width - 30, height: 200)
                .aspectRatio(contentMode: .fit)
                .overlay(ImageOverlay( product: product), alignment: .bottomLeading)
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(#colorLiteral(red: 0.8275, green: 0, blue: 0.1373, alpha: 1)), lineWidth: 1))
            HStack{
                VStack{
            Text(product.text!)
               
                .foregroundColor(Color.black)
                Text(product.detail!)
                    
                    .foregroundColor(Color.black)
                }
                Spacer()
                
                
                VStack{
                    WebImage(url: URL(string: product.userIamge!))
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            .frame(width: 40, height: 40)
                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                            .shadow(radius: 2)
                            
                           
                Text(product.userName!)
                    
                    .foregroundColor(Color.black)
                    
                }
                
                    
            }.padding()
        }
        
    }
}


struct ImageOverlay: View {
    @StateObject var ProductDate = ProductViewModel()
    @State var Show = false
    var product : ProductModel
    var body: some View {
        VStack {
            
            Button {
                Show.toggle()
            } label: {
                WebImage(url: URL(string: product.image!))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 120)
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(20)
                    .shadow(color: Color.black, radius: 4, x: 4, y: 4)
                    .padding(.bottom, 6)
            }
 
        }.sheet(isPresented: $Show) {
          
            ProductDetail(product: product)
        }
        
    }
    
}
