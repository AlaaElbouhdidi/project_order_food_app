//
//  ProfilDetail.swift
//  OrderAndEat
//
//  Created by ii on 17.06.20.
//  Copyright © 2020 OrderAndEat. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfilDetail: View {
    
    @EnvironmentObject var session: SessionStore
    @Environment(\.presentationMode) var presentation
    
    @State var showOrders = false

    
    var body: some View {
        ZStack{
                VStack(alignment: .leading){
                    
                    HStack(alignment: .top){
                        AnimatedImage(url: URL(string: self.session.session?.pic ?? ""))
                            .resizable()
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 1))
                            .shadow(radius: 10)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 140, height: 140)
                        Spacer()
                        Button(action: {
                            self.showOrders.toggle()
                        },
                           label: {
                            VStack{
                                Image("bestellung")
                                    .resizable()
                                    .frame(width: 60, height: 60, alignment: .top)
                                    
                                Text("My Orders")
                                    .font(.system(size: 15))
                                    .foregroundColor(.blue)
                            }
                            }).buttonStyle(PlainButtonStyle())
                        Spacer()
                        Button(action: {
                            self.session.signOut()
                            },
                               label: {
                                VStack{
                                    Image("ausloggen")
                                        .resizable()
                                        .frame(width: 40, height: 40, alignment: .top)
                                        .foregroundColor(.red)
                                    Text("Logout").font(.system(size: 11))
                                        .foregroundColor(.red)
                                }
                            })
                    }.padding()
                    VStack(alignment: .leading){
                        FormView()
                    }
                    Spacer()
                }.padding()
            
            if self.showOrders{
                
                GeometryReader{_ in
                    MyOrdersView(orders: getMyOrders(uid: self.session.session?.uid ?? ""))
                }.background(
                    
                    Color.black.opacity(0.55)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            self.showOrders.toggle()
                    }
                )
            }
        }
    }
}

struct ProfilDetail_Previews: PreviewProvider {
    static var previews: some View {
        ProfilDetail()
    }
}
