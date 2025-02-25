//
//  LogoView.swift
//  MySwiftUIdemo
//
//  Created by Patrick Tung on 2/23/25.
//

import SwiftUI


struct LogoView: View {
    var body: some View {
        VStack {
            HStack {
                Image("appLogo")
                    .resizable()
                    .frame(width: 100, height: 50)
                Spacer() // Pushes the logo to the left
            }
            Spacer() // Pushes the HStack to the top
        }
        .frame(maxWidth: 350, maxHeight: 700) // Ensures the view takes up the full screen
    }
}

#Preview {
    LogoView()
}
