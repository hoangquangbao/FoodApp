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
                
                HStack {
                    
                    Button(action: {
                        withAnimation(.easeIn){HomeModel.showMenu.toggle()}
                    }) {
                        Image(systemName: "lineweight")
                            .font(.title)
                            .foregroundColor(.red)
                            //.padding(.horizontal,10)
                    }
                    
                    Spacer()
                    
                    Text("Boboli Food")
                        .font(.custom("Pacifico-Regular", size: 30))
                        .foregroundColor(.purple)
                
                    Spacer()
                    
                    Button(action: {
                       // The favorite foods
                    }) {
                        Image(systemName: "heart.fill")
                            .font(.title)
                            //.background(Color.red)
                            .foregroundColor(.red)
                            //.padding(.horizontal,10)
                    }
                }
                .padding(.horizontal)
                
                HStack {
                    
//                    Button(action: {
//                        withAnimation(.easeIn){HomeModel.showMenu.toggle()}
//                    }) {
//                        Image(systemName: "lineweight")
//                            .font(.title)
//                            .foregroundColor(.red)
//                            .padding(.horizontal,10)
//                    }

                    Text(HomeModel.userLocation == nil ? "  Locating...." : "  Delivery to")
                        .font(.custom("Pacifico-Regular", size: 15))
                        .foregroundColor(.gray)
                        //.font(.caption2)
                        //.font(.custom("caption", size: 15))
                        //.foregroundColor(.pink)
//                    Text(HomeModel.userLocation == nil ? "Locating...." : HomeModel.noLocation ? "Unknown Customer Address" : "Deliver")
                    //?????????????
                    //Text(".\(CurrentLocation.$locationManager)")
                    Text(HomeModel.userAddress)
                        .font(.custom("Pacifico-Regular", size: 15))
                        .foregroundColor(.gray)
                        //.fontWeight(.bold)
                        //.font(.caption2)
                        //.font(.custom("caption", size: 15))
                        
                        //.fontWeight(.heavy)
                        //.foregroundColor(.purple)
                                        
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
                
                if HomeModel.items.isEmpty {
                    
                    Spacer()
                    
                    ProgressView()
                    
                    Spacer()
                }
                else {
                    
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
                                            .background(Color.red)
                                        
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
            }
            
            if HomeModel.noLocation {
                
                VStack(spacing: 5) {
                    
                    Text("Boboli Food")
                        .padding(.horizontal)
                        .font(.custom("Pacifico-Regular", size: 15))
                        .foregroundColor(.purple)
                    
                    Text("Please Enable Location Access In Settings To Further Move On !!!")
                        .padding(.horizontal)
                        .foregroundColor(.black)
//                        .frame(width: UIScreen.main.bounds.width - 100, height: 120)
//                        .background(Color.black)
//                        .cornerRadius(10)
//                        .frame(maxWidth: .infinity, maxHeight: .infinity)
//                        .background(Color.black.opacity(0.6).ignoresSafeArea())
                }
                .frame(width: UIScreen.main.bounds.width - 100, height: 120)
                .background(Color.white)
                .cornerRadius(10)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black.opacity(0.6).ignoresSafeArea())
                
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
            
//            if HomeModel.noLocation {
//
//                Text("Please Enable Location Access In Settings To Further Move On !!!")
//                    .foregroundColor(.black)
//                    .frame(width: UIScreen.main.bounds.width - 100, height: 120)
//                    .background(Color.white)
//                    .cornerRadius(10)
//                    //.frame(width: .infinity, height: .infinity)
//                    .background(Color.black.opacity(0.3).ignoresSafeArea())
//            }
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

