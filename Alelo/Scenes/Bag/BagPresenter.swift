import UIKit

protocol BagPresentationLogic {
    func presentEmptyState()
    func presentItems(items: [BagItem])
    func presentTotal(total: String)
}

class BagPresenter: BagPresentationLogic {
    weak var viewController: BagDisplayLogic?
    
    func presentItems(items: [BagItem]) {
        viewController?.displayItems(items: items)
    }
    
    func presentTotal(total: String) {
        viewController?.displayTotal(total: total)
    }
    
    func presentEmptyState() {
        viewController?.presentEmptyState()
    }
}
