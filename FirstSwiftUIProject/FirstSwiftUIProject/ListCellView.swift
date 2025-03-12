//
//  ListCellView.swift
//  FirstSwiftUIProject
//
//  Created by Patrick Tung on 2/21/25.
//

import SwiftUI

struct ListCellView: View {
    let data: String
    var body: some View {
        HStack {
            Text(data)
        }
    }
}

#Preview {
    ListView()
}
