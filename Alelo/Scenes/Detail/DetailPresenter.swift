import UIKit

protocol DetailPresentationLogic {
    func present(product: Product)
    func presentEmptyBag()
    func presentNotEmptyBag()
    func display(quantity: Int)
}

class DetailPresenter {
    weak var viewController: DetailDisplayLogic?
}

extension DetailPresenter: DetailPresentationLogic {
  
    func present(product: Product) {
        viewController?.display(url: product.image)
        viewController?.display(name: product.name)
        viewController?.displayOnSale(isOnSale: product.onSale)
        viewController?.display(sizes: product.sizes.filter({ $0.available }).map({ $0.size }).joined(separator: ", "))
        viewController?.display(price: product.priceAttributed())
    }
    
    func presentNotEmptyBag() {
        viewController?.presentBagState(false)
    }
    
    func presentEmptyBag() {
        viewController?.presentBagState(true)
    }
    
    func display(quantity: Int) {
        viewController?.display(quantity: quantity)
    }
}
