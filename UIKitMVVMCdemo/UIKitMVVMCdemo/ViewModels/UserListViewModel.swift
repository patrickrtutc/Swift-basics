import Foundation

class UserListViewModel {
    private weak var coordinator: MainCoordinator?
    private let users: [User]
    
    init(coordinator: MainCoordinator, users: [User]) {
        self.coordinator = coordinator
        self.users = users
    }
    
    var numberOfUsers: Int {
        return users.count
    }
    
    func user(at index: Int) -> User {
        return users[index]
    }
    
    func didSelectUser(at index: Int) {
        let user = users[index]
        coordinator?.goToUserDetails(user: user)
    }
    
    func navigateBack() {
        coordinator?.goBack()
    }
} 