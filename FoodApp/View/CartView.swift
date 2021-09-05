//
//  CartView.swift
//  FoodApp
//
//  Created by Quang Bao on 04/09/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct CartView: View {
    
    //@ObservedObject var homeDataCartView : HomeViewModel
    @ObservedObject var homeDataCartView = HomeViewModel()
    @Environment(\.presentationMode) var present
    var body: some View {
        
        VStack {
            
            HStack(spacing: 20) {
                
                Button(action: {present.wrappedValue.dismiss()}) {
                    
                    Image(systemName: "chevron.left")
                        //.font(.system(size: 20, weight: .heavy, design: <#T##Font.Design#>))
                        .font(.system(size: 26, weight: .heavy))
                        .foregroundColor(.gray)
                }
                
                Text("My cart")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(.pink)
                
                Spacer()
            }
            .padding()
            
            ScrollView(.vertical, showsIndicators: false) {
                
                LazyVStack(spacing: 0) {
                    
                    ForEach(homeDataCartView.cartItems) {cart in
                    
                        //Text(item.item.item_name)
                        HStack(spacing: 15) {
                            
                            WebImage(url: URL(string: cart.item.item_image))
                                .resizable()
                                //.aspectRatio(contentMode: .fill)
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 130, height: 130)
                                .cornerRadius(15)
                            
                            VStack(alignment: .leading, spacing: 10) {
                                
                                Text(cart.item.item_name)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                                
                                Text(cart.item.item_details)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                                    .lineLimit(2)
                                
                                HStack(spacing: 15) {
                                    
                                    Text(homeDataCartView.getPrice(value: Float(cart.item.item_cost)))
                                        .font(.title2)
                                        .fontWeight(.heavy)
                                        .foregroundColor(.black)
                                    
                                    Spacer(minLength: 0)
                                    
                                    // Add - Sub Button....
                                    
                                    Button(action: {
                                        
                                        if cart.quantity > 1{
                                            homeDataCartView.cartItems[homeDataCartView.getIndex(item: cart.item, isCartIndex: true)].quantity -= 1
                                        }
                                    }) {
                                        
                                        Image(systemName: "minus")
                                            .font(.system(size: 16, weight: .heavy))
                                            .foregroundColor(.black)
                                    }
                                    
                                    Text("\(cart.quantity)")
                                        //.font(.title)
                                        .fontWeight(.heavy)
                                        .foregroundColor(.black)
                                        .padding(.vertical,5)
                                        .padding(.horizontal,10)
                                        .background(Color.black.opacity(0.06))
                                    
                                    Button(action: {
                                        
                                        homeDataCartView.cartItems[homeDataCartView.getIndex(item: cart.item, isCartIndex: true)].quantity += 1
                                        
                                    }) {
                                        
                                        Image(systemName: "plus")
                                            .font(.system(size: 16, weight: .heavy))
                                            .foregroundColor(.black)
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            
            // Bottom View....
            
            VStack {
                
                HStack {
                    
                    Text("Total")
                        .fontWeight(.heavy)
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    // Caculating Total Price....
                    Text(homeDataCartView.calculateTotalPrice())
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                }
                .padding([.top, .horizontal])
                
                Button(action: {}) {
                    
                    Text("Check out")
                        .font(.title2)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 30)
                        .background(
                            
                            LinearGradient(gradient: .init(colors: [Color("lightblue"),Color.blue]), startPoint: .leading, endPoint: .trailing)
                        )
                        .cornerRadius(15)
                }
            }
            .background(Color.white)
        }
        //.background(Color.gray.ignoresSafeArea())
        //.background(Color.gray.ignoresSafeArea())
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
    }
}

