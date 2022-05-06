//
//  ProductDetail.swift
//  UOapp
//
//  Created by abdullah on 24/09/1443 AH.
//

import SwiftUI
import SDWebImageSwiftUI
import LinkPresentation

struct ProductDetail: View {
    @State private var isPresentingShareSheet = false
    var product : ProductModel
    @State var isAddition = false
    @State var isPressed = false
    @State var isTrue = true
    var body: some View {
        ZStack{
            VStack{
                VStack{
                    WebImage(url: URL(string: product.image!))
                        .resizable()
                       
                        .frame(width: UIScreen.main.bounds.width, height: 400)
                        .scaledToFill()
                        .ignoresSafeArea()
                        
                        
                    HStack{
                       
                        VStack{
                            Text(product.text!)
                                .font(.system(size: 30))
                                .foregroundColor(.black)
                            Text(product.detail!)
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                        }.padding()
                        Spacer()
                        VStack{
                            WebImage(url: URL(string: product.userIamge!))
                                .resizable()
                                .scaledToFill()
                                .clipShape(Circle())
                                .frame(width: 50, height: 50)
                                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                .shadow(radius: 2)
                            Text(product.userName!)
                                .font(.headline)
                                .foregroundColor(.black)
                        }.padding()
                        
                    }
                    Divider()
                    HStack{
                        ZStack {
                                    Image(systemName: "heart.fill")
                                        .opacity(isPressed ? 1 : 0)
                                        .scaleEffect(isPressed ? 1.0 : 0.1)
                                        .animation(.linear,value: isTrue)
                                    Image(systemName: "heart")
                        }.padding()
                        .font(.system(size: 20))
                                    .onTapGesture {
                                        self.isPressed.toggle()
                                }
                                .foregroundColor(isPressed ? .red : .gray)
                        Button {
                            isPresentingShareSheet = true
                        } label: {
                            Image(systemName: "arrowshape.turn.up.forward")
                                .font(.system(size: 20))
                                .foregroundColor(.gray)
                        }.padding()
                        .shareSheet(isPresented: $isPresentingShareSheet, items: ["بالامكان استبدال النص برابط التطبيق من الابل ستور"])
                        ZStack {
                            Image(systemName: "person.fill")
                                        .opacity(isAddition ? 1 : 0)
                                        .scaleEffect(isAddition ? 1.0 : 0.1)
                                        .animation(.linear,value: isTrue)
                            Image(systemName: "person")
                        }.padding()
                        .font(.system(size: 20))
                                    .onTapGesture {
                                        self.isAddition.toggle()
                                }
                                .foregroundColor(isAddition ? .green : .gray)
                       
                    }
                    Divider()
                    VStack{
                Text("اتمنى انه التطبيق مفيد للجميع")
                    .font(.title)
                    .foregroundColor(.black)
                    }.padding(.top,55)
                }
                Spacer()
            }
        }
    }
    
    
    
}




//MARK:- Extensions

extension UIApplication {
    
    static let keyWindow = keyWindowScene?.windows.filter(\.isKeyWindow).first
    static let keyWindowScene = shared.connectedScenes.first { $0.activationState == .foregroundActive } as? UIWindowScene
    
}

extension View {
    
    func shareSheet(isPresented: Binding<Bool>, items: [Any]) -> some View {
        guard isPresented.wrappedValue else { return self }
        let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        let presentedViewController = UIApplication.keyWindow?.rootViewController?.presentedViewController ?? UIApplication.keyWindow?.rootViewController
        activityViewController.completionWithItemsHandler = { _, _, _, _ in isPresented.wrappedValue = false }
        presentedViewController?.present(activityViewController, animated: true)
        return self
    }
    
}



