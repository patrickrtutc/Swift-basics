//
//  ViewState.swift
//  DigimonAPISwiftUICombine
//
//  Created by Patrick Tung on 3/5/25.
//

enum ViewState{
    case idle
    case loading
    case loaded([Digimon])
    case error(Error)
    
    func getDigimon() -> [Digimon]? {
        switch self {
        case .loaded(let digimon):
            return digimon
        default:
            return nil
        }
    }
}
