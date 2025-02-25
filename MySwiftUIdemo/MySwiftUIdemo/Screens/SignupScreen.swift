//
//  SignupScreen.swift
//  MySwiftUIdemo
//
//  Created by Patrick Tung on 2/23/25.
//

import SwiftUI

struct SignupScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack(alignment:.center, spacing: 30) {
                
                HeadingView(heading: "Hi!", subheading: "Create a new account")/*.alignmentGuide(.leading) { $0[HorizontalAlignment.leading] }*/
                
                InputFieldView(placeholder: "Amish567", text: $username)
                InputFieldView(placeholder: "amishkr@gmail.com", text: $email)
                InputFieldView(placeholder: "••••••••", text: $password, isSecure: true)
                
                PrimaryButtonView(title: "SIGN UP", action: {
                    // Handle signup logic here
                }).padding(.top, 25)
                
                Divider()
                Text("or")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                SocialMediaIconsView()
                
                Spacer()
                
                HStack {
                    Text("Already have an account?")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    NavigationLink(destination: LoginScreen()) {
                        Text("Sign in")
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
    SignupScreen()
}
