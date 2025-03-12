import Foundation

class HomeViewModel {
    private weak var coordinator: MainCoordinator?
    
    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
    }
    
    func navigateToUserList() {
        coordinator?.goToUserList()
    }
} 