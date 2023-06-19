import UIKit

protocol DetailRouterLogic: AnyObject {
    func routeToBag()
}

class DetailRouter {
    weak var viewController: DetailViewController?
}

extension DetailRouter: DetailRouterLogic {
    
    // MARK: Routing
    func routeToBag() {
        let controller = BagViewController()
        viewController?.present(controller, animated: true)
    }
}
