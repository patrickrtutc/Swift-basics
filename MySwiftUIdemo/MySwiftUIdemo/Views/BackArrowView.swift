//
//  BackArrowView.swift
//  MySwiftUIdemo
//
//  Created by Patrick Tung on 2/23/25.
//

import SwiftUI

struct BackArrowView: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "arrow.left")
                .foregroundColor(Color(red: 0.0392, green: 0, blue: 0.6))
                .padding()
                .fontWeight(.bold)
        }
    }
}

#Preview {
    BackArrowView(action: {})
}
