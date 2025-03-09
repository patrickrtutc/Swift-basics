//
//  Country.swift
//  SearchableCountryList
//
//  Created by Patrick Tung on 2/24/25.
//

import SwiftUI

struct Country: Decodable {
    let name: String
    let code: String
    let capital: String
    let flag: String
    let region: String
    let currency: Currency
    let language: Language

    struct Currency: Decodable {
        let code: String?
        let name: String?
        let symbol: String?
    }

    struct Language: Decodable {
        let code: String?
        let name: String?
    }
    
    var flagPNG: String {
            "https://flagcdn.com/64x48/\(code.lowercased()).png"
        }
}
