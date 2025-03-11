//
//  DigimonRow.swift
//  DigimonAPISwiftUICombine
//
//  Created by Patrick Tung on 3/4/25.
//

import SwiftUI

struct DigimonRow: View {
    let digimon: Digimon
    @Environment(\.horizontalSizeClass) var sizeClass

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: digimon.img)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: sizeClass == .compact ? 150 : 200,
                   height: sizeClass == .compact ? 150 : 200)
            Text(digimon.name)
            Spacer()
            Text(digimon.level)
                .foregroundColor(.gray)
        }
    }
}

#Preview {
    DigimonRow(digimon: Digimon(name: "Koromon", img: "https://digimon.shadowsmith.com/img/koromon.jpg", level: "In Training"))
}
