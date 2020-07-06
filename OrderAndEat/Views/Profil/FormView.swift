//
//  SwiftUIView.swift
//  OrderAndEat
//
//  Created by ii on 29.06.20.
//  Copyright © 2020 OrderAndEat. All rights reserved.
//

import SwiftUI


struct FormView: View {
    
    
    @State var firstname : String = ""
    @State var lastname :  String = ""
    @State var street :  String = ""
    @State var n :  String = ""
    @State var zip :  String = ""
    @State var city :  String = ""
    
    @EnvironmentObject var session: SessionStore
    
    
    
    
    
    init(){
        UITableView.appearance().backgroundColor = .clear
        
    }
    
    
    var body: some View {
        
        Form{
            Section(header: Text("Edit profile")){
                TextField("First Name", text: $firstname)
                TextField("Last Name", text: $lastname)
            }
            Section(header: Text("Address")){
                TextField("Street", text: $street)
                TextField("N°", text: $n)
                TextField("Zip", text: $zip)
                TextField("City", text: $city)
            }
            Button(action: {
                
            }){
                Text("Save")
            }
        }
        .background(Color.white)
        
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        FormView()
    }
}

