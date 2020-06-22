//
//  ProfilDetail.swift
//  OrderAndEat
//
//  Created by ii on 17.06.20.
//  Copyright © 2020 OrderAndEat. All rights reserved.
//

import SwiftUI

struct ProfilDetail: View {
    
    @EnvironmentObject var session: SessionStore
    
    
    var body: some View {
        VStack(alignment: .leading){
            
            HStack(alignment: .top){
                
                Image(systemName: "person.fill")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
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
                    
                }
                )
            }.padding()
            
                Text((self.session.session?.firstName ?? "")+" "+(self.session.session?.lastName ?? ""))
                .font(.system(size: 32, weight: .heavy))
            
                Spacer()
        }.padding()
        
        
        
        
    }
}

struct ProfilDetail_Previews: PreviewProvider {
    static var previews: some View {
        ProfilDetail()
    }
}
