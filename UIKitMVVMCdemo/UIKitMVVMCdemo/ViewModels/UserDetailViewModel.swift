import Foundation

class UserDetailViewModel {
    private weak var coordinator: MainCoordinator?
    private let user: User
    
    init(coordinator: MainCoordinator, user: User) {
        self.coordinator = coordinator
        self.user = user
    }
    
    var userName: String {
        return user.name
    }
    
    var userAge: String {
        return "Age: \(user.age)"
    }
    
    var userId: String {
        return "ID: \(user.id)"
    }
    
    func navigateBack() {
        coordinator?.goBack()
    }
} 