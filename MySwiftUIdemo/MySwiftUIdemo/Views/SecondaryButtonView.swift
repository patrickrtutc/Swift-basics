//
//  SecondaryButtonView.swift
//  MySwiftUIdemo
//
//  Created by Patrick Tung on 2/23/25.
//

import SwiftUI

struct SecondaryButtonView: View {
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .kerning(2)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(Color(red: 0.0392, green: 0, blue: 0.6))
                .padding()
                .padding(.top, -8)
                .padding(.bottom, -8)
                .frame(maxWidth: .infinity)
                .background(Color.white)
//                .cornerRadius(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color(red: 0.0392, green: 0, blue: 0.6), lineWidth: 3)
                )
        }
        .padding(.horizontal)
        .frame(maxWidth: 280)
    }
}

#Preview {
    SecondaryButtonView(title: "TRY", action: {})
}
