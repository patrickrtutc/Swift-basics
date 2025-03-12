//
//  ResetPassword.swift
//  FirstSwiftUIProject
//
//  Created by Patrick Tung on 2/21/25.
//

import SwiftUI

struct ResetPassword: View {
    @State private var emailID: String = ""
    var body: some View {
        VStack(spacing: 20) {
            Text("Reset Password").font(.largeTitle).fontWeight(.bold)
            Spacer()
            
            TextField("EmailID", text: $emailID).textFieldStyle(RoundedBorderTextFieldStyle()).padding(.horizontal).padding(.bottom, 30)
            
            Button {
                print("Send reset password email to \(emailID)")
            } label: {
                Text("Send")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.orange)
                    .foregroundColor(.white)
                    .cornerRadius(30)
            }
            
            Text("Enter your email and we will send you a new password")
                .foregroundColor(.gray)
                .padding(.horizontal)
            
            NavigationLink{
                ContentView()
            } label: {
                Text("Back to Login")
            }
            
            Spacer()
        }.padding(.horizontal)
    }
}

#Preview {
    ResetPassword()
}
