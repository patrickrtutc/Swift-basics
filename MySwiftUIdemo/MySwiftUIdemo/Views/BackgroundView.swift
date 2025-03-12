//
//  BackgroundView.swift
//  MySwiftUIdemo
//
//  Created by Patrick Tung on 2/23/25.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        Image("backgroundPicture")
            .resizable()
            .frame(width: 260, height: 260)
    }
}

#Preview {
    BackgroundView()
}
