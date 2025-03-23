//
//  PlanetViewModel.swift
//  LinInterviewProject
//
//  Created by Patrick Tung on 2/26/25.
//

import SwiftUI
import Combine

class PlanetViewModel: ObservableObject {
    private let apiService: ApiService
    private var anyCancellable: AnyCancellable?
    init(apiService: Service) {
        self.apiService = apiService
    }
}

#Preview {
    PlanetViewModel()
}
