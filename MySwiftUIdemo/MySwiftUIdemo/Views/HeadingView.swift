//
//  HeadingView.swift
//  MySwiftUIdemo
//
//  Created by Patrick Tung on 2/23/25.
//

import SwiftUI

struct HeadingView: View {
    var heading: String
    var subheading: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(heading)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .kerning(4)
            Text(subheading)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(Color(red: 0.5569, green: 0.5490, blue: 0.7686))
        }
        .padding(.trailing, 160)
        .padding(.top, 25)
        .padding(.leading, 30)
    }
}

#Preview {
    HeadingView(heading: "Welcome!", subheading: "Sign in to continue")
}
