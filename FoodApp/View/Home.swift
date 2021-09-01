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
                
                HStack(spacing: 15){
                    
                    Button(action: {
                        withAnimation(.easeIn){HomeModel.showMenu.toggle()}
                    }) {
                        Image(systemName: "line.3.horizontal")
                            .font(.title)
                            .foregroundColor(.pink)
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
                        .font(.caption)
                        .fontWeight(.heavy)
                        .foregroundColor(.purple)
                    
                    Spacer(minLength: 0)
                }
                .padding([.horizontal,.top])

                Divider()
                
                //HStack(spacing: 15){
                //Add
                HStack(spacing: 15){
                    
                    Image(systemName: "magnifyingglass")
                    .font(.title2)
                    .foregroundColor(.gray)
                    
                    TextField("Search", text: $HomeModel.search)
                }
                //.padding(.leading,20)
                .padding(.horizontal)
                .padding(.top,10)
                
                Divider()
                
                ScrollView(.vertical, showsIndicators: false, content: {
                    
                    VStack(spacing: 25){
                        
                        //ForEach(HomeModel.items){item in
                        ForEach(HomeModel.filtered){item in
                            
                            //Item View....
                            
                            //ZStack(alignment: Alignment(horizontal: .center, vertical: .center), content: {
                            ZStack(alignment: Alignment(horizontal: .center, vertical: .top), content: {
                                
                                ItemView(item: item)
                                    
                                HStack{
                                 
                                    Text("FREE DELIVERY")
                                        //.font(.title2)
                                        .fontWeight(.bold)
                                    
                                        .foregroundColor(.red)
                                        .background(Color("pink"))
                                        //.padding(.vertical,10)
                                        //.padding(.horizontal)
                                        
                                    
                                    Spacer(minLength: 0)
                                    
                                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                                         Image(systemName: "plus")
                                            //.padding(10)
                                            //.font(.title2)
                                            .foregroundColor(.white)
                                            .background(Color("pink"))
                                            .clipShape(Circle())
                                     }
                                }
                                //.padding(.trailing,10)
                                //.padding(.top,10)
                                .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 20))
                            })
                            .frame(width: UIScreen.main.bounds.width - 5)
                        }
                    }
                    //.padding(.vertical)
                    //.padding()
                })
            }
            
            //Side Menu.....
            
            HStack {

                Menu(HomeData: HomeModel)
                //Hiệu ứng di chuyển từ bên trái
                //Move effect from left....
                //Một đối tượng xác định các thuộc tính liên quan đến màn hình dựa trên phần cứng.
                //Trả về đối tượng màn hình đại diện cho màn hình của thiết bị.
                //Hình chữ nhật giới hạn của màn hình, được đo bằng điểm.
                //Trả về chiều rộng của hình chữ nhật.
                    .offset(x: HomeModel.showMenu ? 0 : -UIScreen.main.bounds.width / 1.6)
                
                Spacer(minLength: 0)
            }
            .background(Color.gray.opacity(HomeModel.showMenu ? 0.3 : 0).ignoresSafeArea())
            //Tạo một hành động khi view này nhận dạng được một cử chỉ nhấn
            //Closing when Taps on outside.
            .onTapGesture {
                withAnimation(.easeIn){HomeModel.showMenu.toggle()}
            }
            
        }
        
        //Hành động này ko có tác dụng nếu nhận được giá trị nil
        .onAppear(perform: {

            // Calling location delegate...
            HomeModel.locationManager.delegate = HomeModel
        })
        
        .onChange(of: HomeModel.search, perform: { newValue in
            
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
        
//        .onChange(of: HomeModel.search) { newValue in
//
//            //to avoid continue search request....
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
//
//                if newValue == HomeModel.search && HomeModel.search != ""{
//
//                    //Search Data
//                    HomeModel.filterData()
//                }
//
//            }
//
//            if HomeModel.search == ""{
//                //Reset all data....
//                withAnimation(.linear){HomeModel.filtered = HomeModel.items}
//            }
//        }
    }
}

