//
//  InputFieldView.swift
//  MySwiftUIdemo
//
//  Created by Patrick Tung on 2/23/25.
//

import SwiftUI

struct InputFieldView: View {
    var placeholder: String
    @Binding var text: String
    var isSecure: Bool = false
    
    var body: some View {
        HStack {
            Group {
                if isSecure {
                    SecureField(placeholder, text: $text)
                } else {
                    TextField(placeholder, text: $text)
                }
            }
            .frame(maxWidth: 220)
            .padding(.vertical, 10)
            .foregroundColor(Color(red: 0.0392, green: 0, blue: 0.6))
            .fontWeight(.bold)
            .background(
                ZStack(alignment: .bottom) {
                    Color.clear
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray)
                }
            )
            Spacer() // Pushes the input field to the left by filling remaining space on the right
        }
        .padding(.leading, 40)
    }
}

#Preview {
    InputFieldView(placeholder: "Enter email", text: .constant("amishkr@gmail.com"), isSecure: false)
        .padding()
    
    InputFieldView(placeholder: "Enter password", text: .constant("kshdfkkef92743#*&(&#"), isSecure: true).padding()
}
