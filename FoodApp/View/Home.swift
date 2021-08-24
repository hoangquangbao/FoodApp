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
                HStack(spacing: 35){
                    
                    TextField("Search", text: $HomeModel.search)
                    
                    if HomeModel.search != ""{
                        
                        Button(action: {}, label: {
                            
                            Image(systemName: "magnifyingglass")
                            .font(.title2)
                            .foregroundColor(.gray)
                        })
                        .animation(.easeIn)
                    }
                }
                //.padding(.leading,20)
                .padding(.horizontal)
                .padding(.top,10)
                
                Divider()
                
                Spacer()
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
        
        //Thêm 1 hành động để thực thi khi view này hiện ra
        .onAppear(perform: {

            // Calling location delegate...
            HomeModel.locationManager.delegate = HomeModel
        })
    }
}

