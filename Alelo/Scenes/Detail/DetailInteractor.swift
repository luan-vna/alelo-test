import UIKit

protocol DetailBusinessLogic {
    func load(product: Product?)
    func addItem()
    func removeItem()
}

class DetailInteractor {
    var presenter: DetailPresentationLogic?
    var bagManager: BagManager?
    private var product: Product?
}

extension DetailInteractor: DetailBusinessLogic {
    func load(product: Product?) {
        self.product = product
        guard let product = product else {
            return
        }
        presenter?.present(product: product)
        if bagManager?.exist(item: .init(product: product)) == false {
            presenter?.presentEmptyBag()
        }
    }
    
    func addItem() {
        guard let product = product,
              let result = bagManager?.add(item: BagItem(product: product))  else {
            return
        }
        presenter?.display(quantity: result.quantity)
        presenter?.presentNotEmptyBag()
    }
    
    func removeItem() {
        guard let product = product,
              let result = bagManager?.remove(item: BagItem(product: product)) else {
            presenter?.presentEmptyBag()
            return
        }
        presenter?.display(quantity: result.quantity)
    }
}
