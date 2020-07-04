//
//  AddReviewView.swift
//  OrderAndEat
//
//  Created by ii on 17.06.20.
//  Copyright © 2020 OrderAndEat. All rights reserved.
//

import SwiftUI
import FirebaseFirestore



struct AddReviewView: View {
    @State var rating: Int = -1
    @State var review: String = ""
    @EnvironmentObject var session: SessionStore
    var food : Food
    @Environment(\.presentationMode) var presentation
    
    func addReview() {
        if(self.rating != -1){
            var username : String = ((self.session.session?.firstName)! ?? "Anonym"  + " " + (self.session.session?.lastName)!)
            let db = Firestore.firestore()
            db.collection("review")
                .document()
                .setData(["stars":(self.rating+1),"reviewtext":self.review,"foodid":self.food.id,"username": username ,"userpic":self.session.session?.pic ?? " ", "uid": self.session.session?.uid ?? ""]) { (err) in
                    
                    if err != nil{
                        
                        print((err?.localizedDescription)!)
                        return
                    }
                    
                    // it will dismiss the recently presented modal....
                    
                    self.presentation.wrappedValue.dismiss()
            }
        }
    }
    
    
    var body: some View {
        VStack {
            
            VStack (spacing: 18) {
                Text("Add a review")
                .font(.system(size: 32, weight: .heavy))
                
                StarRatingView(rating: $rating)
                TextField("Write a review", text: $review)
                    .frame(height: 255, alignment: .top)
                    .font(.system(size: 20))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color(.black), lineWidth: 1))
                
                
            }
            .padding(.vertical, 64)
            
            Button(action: addReview) {
                Text("Save")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 50)
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .bold))
                    .background(/*@START_MENU_TOKEN@*/Color.blue/*@END_MENU_TOKEN@*/)
                    .cornerRadius(5)
            }
            Spacer()
        }
        .padding(.horizontal, 32)
        
    }
}

struct AddReviewView_Previews: PreviewProvider {
    static var previews: some View {
        AddReviewView(food: Food(id: ""))
    }
}
