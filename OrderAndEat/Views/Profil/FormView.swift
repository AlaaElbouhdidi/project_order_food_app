//
//  SwiftUIView.swift
//  OrderAndEat
//
//  Created by ii on 29.06.20.
//  Copyright © 2020 OrderAndEat. All rights reserved.
//

import SwiftUI
import FirebaseFirestore


struct FormView: View {
    
    @State var firstname : String = ""
    @State var lastname :  String = ""
    @State var street :  String = ""
    @State var n :  String = ""
    @State var zip :  String = ""
    @State var city :  String = ""
    
    @EnvironmentObject var session: SessionStore
    
    @Environment(\.presentationMode) var presentation
    
    
    init(){
        UITableView.appearance().backgroundColor = .clear
    }
    
    func updateUserInfos(fn: String, ln: String, adrs: Address){
        let db = Firestore.firestore()
        let id = self.session.session?.uid ?? ""
        db.document("/users/" + id)
            .updateData(["firstname": fn, "lastname": ln, "street": adrs.street, "n": adrs.n , "zip": adrs.zip, "city": adrs.city]) { (err) in
                
                if err != nil{
                    
                    print((err?.localizedDescription)!)
                    return
                }
        }
    }
    func getDocumentID() -> Void {
        let db = Firestore.firestore()
        let deliveryRef: CollectionReference = db.collection("users")
        let nameQuery: Query = deliveryRef.whereField("uid", isEqualTo: self.session.session?.uid)
        nameQuery.getDocuments(){ (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                    }
                }
        }
    }
    
    func getUserInfos() {
        self.firstname = self.session.session?.firstName as! String
        self.lastname = self.session.session?.lastName as! String
        
        self.street = self.session.session?.address?.street as! String
        self.n = self.session.session?.address?.n as! String
        self.zip = self.session.session?.address?.zip as! String
        self.city = self.session.session?.address?.city as! String
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
                    
                    self.updateUserInfos(fn: self.firstname, ln: self.lastname, adrs: Address(street: self.street, n: self.n, city: self.city, zip: self.zip))

                    self.session.listen()
                    self.presentation.wrappedValue.dismiss()
                }){
                    Text("Save")
                }
            }
            .onAppear(){
                self.getUserInfos()
            }
            .background(Color.white)
        
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        FormView()
    }
}

