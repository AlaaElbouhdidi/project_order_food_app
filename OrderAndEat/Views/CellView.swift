//
//  CellView.swift
//  OrderAndEat
//
//  Created by ii on 16.06.20.
//  Copyright © 2020 OrderAndEat. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct CellView: View {
    var data : food
    @State var show = false
    
    var body: some View {
        VStack{
            AnimatedImage(url: URL(string: data.pic)!).resizable().frame(height: 270)
            
            HStack{
                
                VStack(alignment: .leading){
                    
                    Text(data.name)
                        .font(.title)
                        .fontWeight(.heavy)
                    
                    Text(data.price+" €")
                        .fontWeight(.heavy)
                        .font(.body)
                }
                
                Spacer()
            
                Button(action: {
                    
                    self.show.toggle()
                    
                }) {
                    
                    Image(systemName: "plus")
                        .font(.body)
                        .foregroundColor(.black)
                        .padding(14)
                    
                }.background(Color.yellow)
                    .clipShape(Circle())
                
            }.padding(.horizontal)
                .padding(.bottom,6)
            
        }.background(Color.white)
            .cornerRadius(20)
            .sheet(isPresented: self.$show) {
                
                OrderView(data: self.data)
        }
        
    }
    
}
