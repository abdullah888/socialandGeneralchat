//
//  Home.swift
//  UOapp
//
//  Created by abdullah on 20/09/1443 AH.
//

//import SwiftUI
//
//struct Home: View {
//    @StateObject var ProductDate = ProductViewModel()
//    var body: some View {
//        NavigationView{
//            VStack{
//                VStack{
//
//                    if ProductDate.products.count != 0 {
//
//                        ProgressView()
//
//                    } else {
//                        ScrollView(.vertical, showsIndicators: false) {
//
//                            VStack(spacing: 25){
//                                ForEach(ProductDate.Productdatas){ product in
//                                   ProductCell(product: product)
//
//                                }
//
//
//                            }
//                        }
//
//                    }
//                }
//            }
//        }
//    }
//
//}
//
//struct Home_Previews: PreviewProvider {
//    static var previews: some View {
//        Home()
//    }
//}




import SwiftUI

struct Home: View {
    @StateObject var profileDate = ProfileViewModel()
    @StateObject var ProductDate = ProductViewModel()
    @State var show = false
    @State var show2 = false
    @State var show3 = false
    private var columns: [GridItem] = [
        GridItem(.fixed(100), spacing: 28),
        GridItem(.fixed(100), spacing: 28),
        GridItem(.fixed(100), spacing: 28)
    ]
    var body: some View {
            VStack{
                HStack{
                    Spacer()
                    Text(profileDate.userInfo.Name!)
                        .font(.headline)
                        .foregroundColor(.black)
                    Button {
                       show3 = true
                    } label: {
                       Image(systemName: "text.bubble.fill")
                            .font(.largeTitle)
                            .foregroundColor(.black)
                    }

                    
                    if profileDate.userInfo.Name != "" {
                        Button {
                        show = true
                        } label: {
                           Image(systemName: "plus.app.fill")
                                .font(.largeTitle)
                                .foregroundColor(.black)
                        }
                    } else {
                        Button {
                        show2 = true
                        } label: {
                           Image(systemName: "plus.app.fill")
                                .font(.largeTitle)
                                .foregroundColor(.black)
                        }
                    }
                }.padding()
                VStack{
                    if ProductDate.products.count != 0 {
                        ProgressView()
                    } else {
                        ScrollView{
                            LazyVGrid(
                                columns: columns,
                                alignment: .center,
                                spacing: 3,
                                pinnedViews: [.sectionHeaders, .sectionFooters]
                            ) {
                                    ForEach(ProductDate.Productdatas){ product in
                                        ImageOverlay(product: product)
                            }
                        }
                    }
                }
            }
            }.sheet(isPresented: $show) {
                Add()
            }
            .sheet(isPresented: $show2) {
                AddProfile()
            }
            .sheet(isPresented: $show3) {
                Chat()
            }
    }
   
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}


