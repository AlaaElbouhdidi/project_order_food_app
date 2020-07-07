//
//  SessionStore.swift
//  OrderAndEat
//
//  Created by ii on 16.06.20.
//  Copyright © 2020 OrderAndEat. All rights reserved.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import Combine

class SessionStore: ObservableObject {
    var didChange = PassthroughSubject<SessionStore, Never>()
    @Published var session: User? {didSet {self.didChange.send(self) }}
    var handle: AuthStateDidChangeListenerHandle?
    
    func listen() {
        handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            
            if let user = user {
                self.session = User(uid: user.uid, email: user.email)
                self.fetchUserInfos(uid: user.uid)
            } else {
                self.session = nil
            }
        })
        
    }
    
    func signUp(email: String, password: String, handler: @escaping AuthDataResultCallback) {
        Auth.auth().createUser(withEmail: email, password: password, completion: handler)
    }
    
    func signIn (email: String, password: String, handler: @escaping AuthDataResultCallback) {
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }
    
    func addNewUser(uid: String, firstName: String, lastName: String){
        
        //implement Database
        let db = Firestore.firestore()
        
        //adding new Data in "users" Collection
        db.collection("users").document(uid).setData([
            "firstname": firstName,
            "lastname": lastName,
            "pic": "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
            "uid": uid
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added")
            }
        }
    }
    
    func fetchUserInfos(uid: String) {
        //implement Database
        let db = Firestore.firestore()
    
        //adding new Data in "users" Collection
        let userRef = db.collection("users")
        var query = userRef.whereField("uid", isEqualTo:  uid)
        query.getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let firstname = document.get("firstname") as? String ?? ""
                        let lastname = document.get("lastname") as? String ?? ""
                        let pic = document.get("pic") as? String ?? ""
                        
                        let street = document.get("street") as? String ?? ""
                        let n = document.get("n") as? String ?? ""
                        let zip = document.get("zip") as? String ?? ""
                        let city = document.get("city") as? String ?? ""
                        
                        let address = Address(street: street, n: n, city: city, zip: zip)
                        self.session?.firstName = firstname
                        self.session?.lastName = lastname
                        self.session?.pic = pic
                        self.session?.address = address
                    }
                }
        }
    }
    
    func signOut() {
        do{
            try Auth.auth().signOut()
            self.session = nil
        } catch {
            print("Error signing out")
        }
    }
    
    func unbind() {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    deinit {
        unbind()
    }

}

struct User {
    var uid: String
    var email: String?
    var firstName: String?
    var lastName: String?
    var pic: String?
    var address: Address?
    
}
struct Address {
    internal init(street: String? = nil, n: String? = nil, city: String? = nil, zip: String? = nil) {
        self.street = street
        self.n = n
        self.city = city
        self.zip = zip
    }
    
    var street: String?
    var n: String?
    var city: String?
    var zip: String?
    
    internal init() {
        self.street = ""
        self.n = ""
        self.city = ""
        self.zip = ""
    }

}
