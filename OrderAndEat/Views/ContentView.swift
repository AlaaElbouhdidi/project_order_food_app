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
    
    func getUser() {
        session.listen()
    }
    
    
    var body: some View {
        Group{
            if(session.session != nil) {
                Text("Welcome \((self.session.session?.firstName)!)")
                
                Button(action: session.signOut) {
                    Text("Sign out")
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
