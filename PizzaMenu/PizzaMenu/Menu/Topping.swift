import Foundation

enum ToppingType: String, CaseIterable {
    case Sauce
    case Cheese
    case Other
    
    var priority: Int {
            switch self {
            case .Sauce: return 0
            case .Cheese: return 1
            case .Other: return 2
            }
        }
}

struct Topping : Comparable {
    let type: ToppingType
    let name: String
    let isVegan: Bool
    let allergens: [String]
    static func <(lhs: Topping, rhs: Topping) -> Bool {
            if lhs.type.priority != rhs.type.priority {
                return lhs.type.priority < rhs.type.priority
            } else {
                return lhs.name < rhs.name
            }
        }
}
