//
//  PrimaryButtonView.swift
//  MySwiftUIdemo
//
//  Created by Patrick Tung on 2/23/25.
//

import SwiftUI

struct PrimaryButtonView: View {
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .kerning(3)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding()
                .padding(.top, -8)
                .padding(.bottom, -8)
                .frame(maxWidth: .infinity)
                .background(
                    LinearGradient(   gradient: Gradient(colors: [Color(red: 0.0392, green: 0, blue: 0.6), Color(red: 0.0392, green: 0, blue: 0.6).opacity(0.7)]), startPoint: .leading, endPoint: .trailing
                    )
                )
                .cornerRadius(5)
        }
        .padding(.horizontal)
        .frame(maxWidth: 283)
    }
}

#Preview {
    PrimaryButtonView(title: "SIGN UP", action: { })
}
