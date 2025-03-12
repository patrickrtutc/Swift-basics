import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = HomeViewModel(coordinator: self)
        let viewController = HomeViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func goToUserList() {
        let viewModel = UserListViewModel(coordinator: self, users: User.mockUsers())
        let viewController = UserListViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goToUserDetails(user: User) {
        let viewModel = UserDetailViewModel(coordinator: self, user: user)
        let viewController = UserDetailViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goBack() {
        navigationController.popViewController(animated: true)
    }
} 