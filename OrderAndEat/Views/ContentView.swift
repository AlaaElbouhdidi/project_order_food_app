//
//  ContentView.swift
//  OrderAndEat
//
//  Created by ii on 15.06.20.
//  Copyright © 2020 OrderAndEat. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        Home()
            
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(SessionStore())
    }
}
