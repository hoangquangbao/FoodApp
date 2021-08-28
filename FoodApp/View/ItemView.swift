//
//  ItemView.swift
//  FoodApp
//
//  Created by Quang Bao on 25/08/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct ItemView: View {
    
    var item: Items
    var body: some View {
        
        VStack{
            
            //Downloading Image From Web....
            
            WebImage(url: URL(string: item.item_image))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 250)
                //.frame(maxwidth: infini, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                //.frame(width: 250)
            
            HStack(spacing: 8){
                
                Text(item.item_name)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .font(.title2)
                
                Spacer(minLength: 0)
                
                //Ratings View....
                
                ForEach(1...5,id: \.self){index in
                    
                    Image(systemName: "star.fill")
                        .foregroundColor(index <= Int(item.item_raitings) ?? 0 ? .pink : .gray)
                }
            }
            
            HStack{
                
                Text(item.item_details)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .lineLimit(2)
                
                Spacer(minLength: 0)
            }
        }
    }
}

