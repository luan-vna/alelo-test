import UIKit

enum HomePresentationState {
    case loading(isLoading: Bool)
    case data(response: [Product])
    case error
}

protocol HomePresentationLogic {
    func present(response: HomePresentationState)
}

class HomePresenter {
    weak var viewController: HomeDisplayLogic?
}

extension HomePresenter: HomePresentationLogic {
    func present(response: HomePresentationState) {
        DispatchQueue.main.async { [ weak self] in
            switch response {
            case .loading(let isLoading):
                self?.viewController?.presentLoading(isLoading: isLoading)
            case .data(let response):
                self?.viewController?.presentAllCatalog(products: response)
            case .error:
                self?.viewController?.presentError()
            }
        }
    }
}
