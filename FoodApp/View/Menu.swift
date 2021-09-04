//
//  Menu.swift
//  FoodApp
//
//  Created by Quang Bao on 24/08/2021.
//

import SwiftUI

struct Menu: View {
    
    @ObservedObject var homeDataMenu = HomeViewModel()
    var body: some View {
        
        VStack {
            
            NavigationLink(destination: CartView(homeDataCartView: homeDataMenu)) {
                
                HStack(spacing: 15){
                    
                    Image(systemName: "cart")
                        .font(.title2)
                        .foregroundColor(.pink)
                    
                    Text("Cart")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    Spacer(minLength: 0)
                }
                .padding()
            }
            
            Spacer()
            
            HStack{
                
                Spacer()
                
                Text("Version 1.0")
                    .fontWeight(.bold)
                    .foregroundColor(.pink)
            }
            //.padding(10)
        }
        .padding([.top,.trailing])
        .frame(width: UIScreen.main.bounds.width/1.2)
        .background(Color.white.ignoresSafeArea())
    }
}

