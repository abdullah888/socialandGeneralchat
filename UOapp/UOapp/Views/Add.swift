//
//  Add.swift
//  UOapp
//
//  Created by abdullah on 21/09/1443 AH.
//

import SwiftUI

struct Add: View {
    
    
    @StateObject var Productdata = ProductViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State var picker = false
    
    //@State var img_Data = Data(count: 0)
    var body: some View {
        NavigationView{
            VStack{
                
                VStack{
                    if Productdata.img_Data.count != 0 {
                        Image(uiImage: UIImage(data: Productdata.img_Data)!)
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width - 30, height: UIScreen.main.bounds.height / 3)
                            .cornerRadius(20)
                        
                    } else {
                        Image("33")
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width - 30, height: UIScreen.main.bounds.height / 3)
                            .cornerRadius(20)
                    }
                    
                }.onTapGesture(perform: {
                    self.picker = true
                })
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "pencil")
                        TextField("Text", text: $Productdata.text)
                    }.underlineTextField()
                    
                    HStack {
                        Image(systemName: "lasso.and.sparkles")
                        TextField("Detail", text: $Productdata.detail)
                        
                    }.underlineTextField()
                    if Productdata.img_Data.count != 0 && Productdata.text != "" && Productdata.detail != ""{
                        Button {
                            
                            Productdata.UploadProduct()
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("انتهي")
                                .font(.title2)
                                .fontWeight(.heavy)
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 30)
                                .background(Color.green)
                                .cornerRadius(15)
                        }
                        
                    } else {
                        Text("تعبيئة جميع الخانات")
                            .font(.title2)
                            .fontWeight(.heavy)
                            .foregroundColor(Color.white)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 30)
                            .background(.black)
                            .cornerRadius(15)
                    }
                    
                    
                }.padding()
            }.navigationTitle("صفحة الاضافة")
            
        }.sheet(isPresented: $picker) {
            
            ImagePicker(picker: $picker, img_Data: $Productdata.img_Data)
        }
        
    }
}





extension Color {
    static let darkPink = Color(#colorLiteral(red: 0.2101026773, green: 0.2532279789, blue: 0.3404707909, alpha: 1))
}
extension View {
    func underlineTextField() -> some View {
        self
            .padding(.vertical, 10)
            .overlay(Rectangle().frame(height: 2).padding(.top, 35))
            .foregroundColor(.darkPink)
            .padding(10)
    }
}
