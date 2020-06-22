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
        var ref: DocumentReference? = nil
        ref = db.collection("users").addDocument(data: [
            "firstname": firstName,
            "lastname": lastName,
            "uid": uid
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
    func fetchUserInfos(uid: String){
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
                        self.session?.firstName = firstname
                        self.session?.lastName = lastname
                        
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

    
    init(uid: String, email:String?){
        self.uid = uid
        self.email = email
        self.firstName = ""
        self.lastName = ""
    }
}
