//
//  LoginScreen.swift
//  MySwiftUIdemo
//
//  Created by Patrick Tung on 2/23/25.
//

import SwiftUI

struct LoginScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack(alignment: .center, spacing: 30) {
            
            HeadingView(heading: "Welcome!", subheading: "Sign in to continue")
            
            Spacer()
            
            InputFieldView(placeholder: "amishkr@gmail.com", text: $email)
            InputFieldView(placeholder: "••••••••", text: $password, isSecure: true)
            
            Spacer()
            
            PrimaryButtonView(title: "LOGIN", action: {
                // Handle login logic here
            })
            
            Text("Forgot Password?")
                .font(.footnote)
                .foregroundColor(
                    Color(red: 0.4667, green: 0.4941, blue: 0.6510)
                )
                .fontWeight(.bold)
            
            Divider()
            Text("or")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            SocialMediaIconsView()
            
            Spacer()
            
            HStack {
                Text("Don’t have an account?")
                    .font(.footnote)
                    .foregroundColor(.gray)
                NavigationLink(destination: SignupScreen()) {
                    Text("Sign up")
                        .font(.footnote)
                        .foregroundColor(.blue)
                        .fontWeight(.bold)
                }
            }
        }
        .padding().navigationBarBackButtonHidden(true).navigationBarItems(leading: BackArrowView(action: {
            presentationMode.wrappedValue.dismiss()
        }))
    }
}

#Preview {
    LoginScreen()
}
