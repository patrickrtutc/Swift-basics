//
//  ContentView.swift
//  FirstSwiftUIProject
//
//  Created by Patrick Tung on 2/21/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        @State var emailID = ""
        @State var password = ""
        @State var title = "Sign In"
        
        NavigationStack{
            VStack(alignment: .center, spacing: 16) {
                Text(title)
                    .font(.largeTitle).foregroundStyle(.primary).padding(.top, 50).padding(.bottom, 80)
                
                TextField("Email", text: $emailID)
                    .textFieldStyle(.roundedBorder).padding(.horizontal)
                
                SecureField("Password", text: $password)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                    .padding(.bottom, 50)
                
                //                Button(action: {
                //                    print("Signing in with email: \(emailID), password: \(password)")
                //                }) {
                //                    Text("Sign In") .font(.headline)
                //                }
                
                NavigationLink{
                    ListView()
                } label: {
                    Text("Sign In").frame(width: 300)
                }.buttonStyle(.borderedProminent).cornerRadius(13).padding(.bottom, 20)
                
                NavigationLink{
                    ResetPassword()
                } label: {
                    Text("Forgot the Password?").foregroundStyle(.gray)
                }.padding(.top, 15)
                
                
                HStack{
                    Rectangle()
                        .foregroundStyle(.gray)
                        .frame(width: .infinity, height: 1)
                    
                    Text("or").foregroundStyle(.gray)
                    
                    Rectangle()
                        .foregroundStyle(.gray)
                        .frame(width: .infinity, height: 1)
                }.padding(.top, 40).padding(.bottom, 40)
                
                Button{} label: {
                    HStack {
                        Image(systemName: "f.circle.fill")
                        Text("Sign In with Facebook")
                    }.frame(maxWidth: .infinity).padding(.horizontal, 20).overlay(
                        RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 1)
                    )
                }
                
                Button{} label: {
                    HStack {
                        Image(systemName: "g.circle.fill")
                        Text("Sign In with Google")
                    }.frame(maxWidth: .infinity).padding(.horizontal, 20).overlay(
                        RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 1)
                    )
                }
            }
            .padding()
            .navigationTitle("Login Screen")
            .navigationBarTitleDisplayMode(.automatic)
            
            HStack{
                Text("Don't have an account?").foregroundColor(.gray).padding(.trailing, 10)
                Button {
                } label: {
                    Text("Sign Up").foregroundStyle(.orange).underline()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
