//
//  WelcomeScreenView.swift
//  MySwiftUIdemo
//
//  Created by Patrick Tung on 2/23/25.
//

import SwiftUI

struct WelcomeScreen: View {
    var body: some View {
        NavigationStack{
            VStack(alignment: .center, spacing: 16) {                
                LogoView().padding(.top, 50)
                
                BackgroundView().padding(.top, 50)
                
                VStack(alignment: .center, spacing: 16) {
                    Text("Hello !")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .kerning(4)
                        .font(.custom("Poppins-Bold", size: 24))
                        
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Best Place to write life stories and")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(Color(red: 0.5569, green: 0.5490, blue: 0.7686))
                                .padding(.leading, 10)
                                .padding(.bottom, 3)
                                .kerning(1)
                                
                        Text("share your journey experiences")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(red: 0.5569, green: 0.5490, blue: 0.7686))
                                    .frame(maxWidth: 300, alignment: .center)
                                    .kerning(1)
                            }
                    .frame(maxWidth: 300, alignment: .center)
                    .padding(.bottom, 40)
            }
                
                NavigationLink(destination: LoginScreen()) {
                    PrimaryButtonView(title: "LOGIN", action: {})
                        .disabled(true) // Disable action since NavigationLink handles it
                }
                
                NavigationLink(destination: SignupScreen()) {
                    SecondaryButtonView(title: "SIGNUP", action: {})
                        .disabled(true)
                }
                .padding(.top, 5)
                .padding(.bottom, 160)
            }
            .padding()
        }
    }
}

#Preview {
    WelcomeScreen()
}
