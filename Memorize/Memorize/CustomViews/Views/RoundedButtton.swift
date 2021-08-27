//
//  RoundedButtton.swift
//  Memorize
//
//  Created by Gabriel on 8/18/21.
//

import SwiftUI

struct RoundedButton: View {
    var text: String
    var action: () -> Void
    var backgroundColor = Color.darkSensitive.black
    var foregoundColor = Color.darkSensitive.white
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(text)
                    .fontWeight(.semibold)
                    .font(.title3)
            }
            .padding(10)
            .foregroundColor(foregoundColor)
            .background(backgroundColor)
            .cornerRadius(10)
        }
    }
}
