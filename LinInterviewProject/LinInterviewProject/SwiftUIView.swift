//
//  SwiftUIView.swift
//  LinInterviewProject
//
//  Created by Patrick Tung on 2/26/25.
//

import SwiftUI

struct ApiService: Service {
    private let session: URLSession
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func fetch<T: Decodable>(_ url: URL) async throws -> T {
        
    }
}
#Preview {
    SwiftUIView()
}
