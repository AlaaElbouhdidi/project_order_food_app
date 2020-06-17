//
//  StarRatingView.swift
//  OrderAndEat
//
//  Created by ii on 17.06.20.
//  Copyright © 2020 OrderAndEat. All rights reserved.
//

import SwiftUI

struct StarRatingView: View {
    @Binding var rating: Int
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach(0..<5){i in
                
                Image(systemName: "star.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(self.rating >= i ? .yellow : .gray)
                    .onTapGesture {
                        self.rating = i
                }
            }
        }
        
    }
}

struct StarRatingView_Previews: PreviewProvider {
    static var previews: some View {
        StarRatingView(rating: .constant(-1))
    }
}
