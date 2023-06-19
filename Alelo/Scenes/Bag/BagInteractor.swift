import UIKit

protocol BagBusinessLogic {
    func loadBag()
    func addItem(product: Product)
    func removeItem(product: Product)
}

class BagInteractor {
    var presenter: BagPresentationLogic?
    var bagManager: BagManager?
}

extension BagInteractor: BagBusinessLogic {
    func loadBag() {
        guard let items = bagManager?.all(),
              let total = bagManager?.total().toCurrency() else {
            presenter?.presentEmptyState()
            return
        }
        if !items.isEmpty {
            presenter?.presentItems(items: items.sorted(by: { $0.product.name.compare($1.product.name) == .orderedAscending }))
            presenter?.presentTotal(total: total)
        } else {
            presenter?.presentEmptyState()
        }
    }

    func addItem(product: Product) {
        bagManager?.add(item: .init(product: product))
        loadBag()
    }
    
    func removeItem(product: Product) {
        bagManager?.remove(item: .init(product: product))
        loadBag()
    }
}
