//
//  AddReviewView.swift
//  OrderAndEat
//
//  Created by ii on 17.06.20.
//  Copyright © 2020 OrderAndEat. All rights reserved.
//

import SwiftUI




struct AddReviewView: View {
    @State var rating: Int = -1
    @State var review: String = ""
    
    
    
    var body: some View {
        VStack {
            
            VStack (spacing: 18) {
                Text("Add a review")
                .font(.system(size: 32, weight: .heavy))
                
                StarRatingView(rating: $rating)
                TextField("Write a review", text: $review)
                    .frame(height: 255, alignment: .top)
                    .font(.system(size: 14))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color(.black), lineWidth: 1))
                
                
            }
            .padding(.vertical, 64)
            
            Button(action: {}) {
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
        AddReviewView()
    }
}
