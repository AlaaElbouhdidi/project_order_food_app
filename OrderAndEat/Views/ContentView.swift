//
//  ContentView.swift
//  OrderAndEat
//
//  Created by ii on 15.06.20.
//  Copyright © 2020 OrderAndEat. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var session: SessionStore
    @State var show = false
    
    func getUser() {
        session.listen()
    }
    
    
    var body: some View {
        Group{
            if(session.session != nil) {
                ZStack{
                    
                    NavigationView{
                        
                        Home()
                            .navigationBarTitle("Home",displayMode: .inline)
                            .navigationBarItems(leading:
                                Button(action: {
                                    
                                    self.session.signOut()
                                    
                                }, label: {
                                    
                                    Text("Sign out").font(.body).foregroundColor(.black)
                                })
                                ,trailing:
                                Button(action: {
                                    
                                    self.show.toggle()
                                    
                                }, label: {
                                    
                                    Image(systemName: "cart.fill").font(.body).foregroundColor(.black)
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
            } else {
                AuthView()
            }
        }.onAppear(perform: getUser)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(SessionStore())
    }
}
