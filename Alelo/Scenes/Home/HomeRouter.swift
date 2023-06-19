import UIKit

protocol HomeRoutingLogic: AnyObject { 
    func routeToBag()
    func routeTo(product: Product)
    func routeToError(tryAgain: @escaping (() -> Void))
}

class HomeRouter: HomeRoutingLogic {
    weak var viewController: HomeViewController?
  
    // MARK: Routing
    func routeToBag() {
        let controller = BagViewController()
        let nav = UINavigationController(rootViewController: controller)
        viewController?.present(nav, animated: true)
    }
    
    func routeTo(product: Product) {
        let controller = DetailViewController(product: product)
        if let presentationController = controller.presentationController as? UISheetPresentationController {
            presentationController.detents = [.medium()]
        }
        viewController?.present(controller, animated: true)
    }
    
    func routeToError(tryAgain: @escaping (() -> Void)) {
        let alertController = UIAlertController(title: "Atenção",
                                           message: "Não conseguimos carregar as informações.\nTente novamente",
                                           preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Tentar novamente", style: .default, handler: { _ in
            tryAgain()
        }))
        viewController?.present(alertController, animated: true)
    }
}
