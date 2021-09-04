//
//  Home.swift
//  FoodApp
//
//  Created by Quang Bao on 23/08/2021.
//

import SwiftUI

struct Home: View {
    
    @StateObject var HomeModel = HomeViewModel()
    
    
    var body: some View {
        
        ZStack {

            VStack(spacing: 10){
                
                HStack(spacing: 10){
                    
                    Button(action: {
                        withAnimation(.easeIn){HomeModel.showMenu.toggle()}
                    }) {
                        Image(systemName: "line.3.horizontal")
                            .font(.title)
                            .foregroundColor(.pink)
                            .padding(.horizontal,10)
                    }

                    Text(HomeModel.userLocation == nil ? "Locating...." : "Deliver to")
                        .foregroundColor(.black)
//                    Text(HomeModel.userLocation == nil ? "Locating...." : HomeModel.noLocation ? "Unknown Customer Address" : "Deliver")
//                    if HomeModel.noLocation {
//
//                        Text("Haven't address's customer").foregroundColor(.black)}
                    //?????????????
                    //Text(".\(CurrentLocation.$locationManager)")
                    Text(HomeModel.userAddress)
                        //.font(.caption)
                        //.font(.custom("caption", size: 15))
                        .fontWeight(.heavy)
                        .foregroundColor(.purple)
                    
                    Spacer(minLength: 0)
                }
//                .padding([.horizontal,.top])

                Divider()
                
                //HStack(spacing: 15){
                //Add
                HStack(spacing: 15){
                    
                    Image(systemName: "magnifyingglass")
                    .font(.title2)
                    .foregroundColor(.gray)
                    
                    TextField("Search", text: $HomeModel.search)
                    //TextField(<#T##titleKey: LocalizedStringKey##LocalizedStringKey#>, text: <#T##Binding<String>#>)
                }
                //.padding(.leading,20)
                .padding(.horizontal)
                //.padding(.top,5)
                
                Divider()
                
                ScrollView(.vertical, showsIndicators: false, content: {
                    
                    VStack(spacing: 25){
                        
                        //ForEach(HomeModel.items){item in
                        ForEach(HomeModel.filtered){item in
                            
                            //Item View....

                            ZStack(alignment: Alignment(horizontal: .center, vertical: .top), content: {
                                
                                ItemView(item: item)
                                
                                HStack{
                                    
                                    Text(" FREE DELIVERY ")
                                        //.font(.title3)
                                        //.fontWeight(.bold)
                                        .padding(5)
                                        .foregroundColor(.white)
                                        .background(Color.pink)
                                    
                                    Spacer(minLength: 0)
                                    
                                    Button(action: {
                                        
                                        HomeModel.addToCart(item: item)
                                        
                                    }) { Image(systemName: item.isAdded ? "checkmark" : "plus")
                                            .padding(10)
                                            .foregroundColor(.white)
                                            .background(item.isAdded ? Color.green : Color.pink)
                                            .clipShape(Circle())
                                     }
                                    .padding(.trailing,10)
                                }
                                .padding(.top,10)
                                //.padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
                            })
                            //.frame(width: UIScreen.main.bounds.width - 30)
                        }
                    }
                    .padding(.horizontal, 5)
                    //.padding()
                })
            }
    
            
            //Side Menu.....
            
            HStack {

                Menu(homeDataMenu: HomeModel)
                //Hiệu ứng di chuyển từ bên trái
                //Move effect from left....
                //Một đối tượng xác định các thuộc tính liên quan đến màn hình dựa trên phần cứng.
                //Trả về đối tượng màn hình đại diện cho màn hình của thiết bị.
                //Hình chữ nhật giới hạn của màn hình, được đo bằng điểm.
                //Trả về chiều rộng của hình chữ nhật.
                    .offset(x: HomeModel.showMenu ? 0 : -UIScreen.main.bounds.width / 1.2)
                
                Spacer(minLength: 0)
            }
//            .background(
//                Color.gray.opacity(HomeModel.showMenu ? 0.3 : 0).ignoresSafeArea()
//                //Closing when Taps on outside.
//                    .onTapGesture(perform: {
//                        withAnimation(.easeIn){HomeModel.showMenu.toggle()}
//                    })
//            )
            .onTapGesture(perform: {
                withAnimation(.easeIn){HomeModel.showMenu.toggle()}
            })
        }

        //Hành động này ko có tác dụng nếu nhận được giá trị nil
        .onAppear(perform: {

            // Calling location delegate...
            HomeModel.locationManager.delegate = HomeModel
        })
        
        .onChange(of: HomeModel.search, perform: { newValue in
            
            //to avoid continue search request....
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                
                if newValue == HomeModel.search && HomeModel.search != ""{
                    
                    //Search Data
                    HomeModel.filterData()
                }
                    
            }
            
            if HomeModel.search == ""{
                //Reset all data....
                withAnimation(.linear){HomeModel.filtered = HomeModel.items}
            }
        })
    }
}

