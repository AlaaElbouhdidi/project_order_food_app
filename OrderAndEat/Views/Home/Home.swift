//
//  Home.swift
//  OrderAndEat
//
//  Created by ii on 16.06.20.
//  Copyright © 2020 OrderAndEat. All rights reserved.
//

import SwiftUI

struct Home: View {
    
    @EnvironmentObject var session: SessionStore
    @State var show = false
    @ObservedObject var food = getFoodData()
    
    func getUser() {
           session.listen()
       }
    
    var body: some View {
        Group{
            if(session.session != nil) {
                ZStack{
                    NavigationView{
                        VStack{
                            if self.food.data.count != 0{
                                ScrollView(.vertical, showsIndicators: false) {
                                    VStack(spacing: 15){
                                        ForEach(self.food.data) {i in
                                            
                                            CellView(data: i)
                                            
                                        }
                                    }.padding()
                                }
                            }
                            else {
                                Loader()
                            }
                            
                        }
                        .navigationBarTitle("Home",displayMode: .inline)
                        .navigationBarItems(leading:
                            NavigationLink(destination: ProfilDetail()){
                                Image(systemName: "person.fill")
                                .font(.body).foregroundColor(.black)
                            }
                            ,trailing:
                            Button(action: {
                                
                                self.show.toggle()
                                
                            }, label: {
                                
                                Image(systemName: "cart.fill")
                                    .font(.body).foregroundColor(.black)
                            })
                        )
                    }
                    
                    if self.show{
                        
                        GeometryReader{_ in
                            
                            CartView()
                            
                        }.background(
                            
                            Color.black.opacity(0.55)
                                .edgesIgnoringSafeArea(.all)
                                .onTapGesture {
                                    self.show.toggle()
                            }
                        )
                    }
                    
                }
            }
            else {
                AuthView()
            }
        }.onAppear(perform: getUser)
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
