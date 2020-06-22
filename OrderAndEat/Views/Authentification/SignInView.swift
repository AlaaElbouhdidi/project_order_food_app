//
//  SignInView.swift
//  OrderAndEat
//
//  Created by ii on 16.06.20.
//  Copyright © 2020 OrderAndEat. All rights reserved.
//

import SwiftUI

struct SignInView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var error: String = ""
    @EnvironmentObject var session: SessionStore
    
    func signIn() {
        session.signIn(email: email, password: password) { (result, error) in
            if let error = error {
                self.error = error.localizedDescription
            } else {
                self.email = ""
                self.password = ""
            }
        }
    }
    
    var body: some View {
        VStack {
            Image("logo")
                .resizable().frame(width: 200, height: 200)
            VStack (spacing: 18) {
                Text("Sign in to continue")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.gray)
                
                TextField("Email adress", text: $email)
                    .font(.system(size: 14))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 5)
                        .strokeBorder(Color(.black), lineWidth: 1))
                
                SecureField("Password", text: $password)
                    .font(.system(size: 14))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 5)
                        .strokeBorder(Color(.black), lineWidth: 1))
            }
            .padding(.vertical, 64)
            
            Button(action: signIn) {
                Text("Sign in")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 50)
                    .foregroundColor(.black)
                    .font(.system(size: 14, weight: .bold))
                    .background(Color.yellow)
                    .cornerRadius(5)
            }
            if(error != "") {
                Text(error)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.red)
                    .padding()
            }
            
            Spacer()
            NavigationLink(destination: SignUpView()) {
                HStack {
                    Text ("I'm a new user.")
                        .font(.system(size: 14, weight: .light))
                        .foregroundColor(.primary)
                    Text("Create an account")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.yellow)
                }
            }.padding(.bottom)
            
        }
            
        .padding(.horizontal, 32)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
