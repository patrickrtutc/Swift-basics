//
//  SocialMediaIconsView.swift
//  MySwiftUIdemo
//
//  Created by Patrick Tung on 2/23/25.
//

import SwiftUI

struct SocialMediaIconsView: View {
    var body: some View {
        HStack(spacing: 20) {
            Button(action: {}) {
                Image("googleLogo")
                    .resizable()
                    .frame(width: 50, height: 50).padding(.trailing, 20)
            }
            Button(action: {}) {
                Image("Facebook_Logo_Primary")
                    .resizable()
                    .frame(width: 50, height: 50)
            }
            Button(action: {}) {
                Image("Apple-logo")
                    .resizable()
                    .frame(width: 45, height: 50).padding(.leading, 20)
            }
        }
        .padding()
    }
}

#Preview {
    SocialMediaIconsView()
}
