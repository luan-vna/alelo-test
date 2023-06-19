import UIKit

protocol HomeBusinessLogic {
    func toggleOnSale()
    func getAll()
}

class HomeInteractor {
    var presenter: HomePresentationLogic?
    var worker: HomeWorker?
    
    private var onSale: Bool = false
    private var productsAux: [Product] = []
}

extension HomeInteractor: HomeBusinessLogic {
    func getAll() {
        Task {
            presenter?.present(response: .loading(isLoading: true))
            guard let response = await worker?.getAll() else {
                presenter?.present(response: .loading(isLoading: false))
                presenter?.present(response: .error)
                return
            }
            presenter?.present(response: .loading(isLoading: false))
            switch response {
            case .success(let response):
                self.productsAux = response.products
                presenter?.present(response: .data(response: response.products))
            case .failure:
                presenter?.present(response: .error)
            }
        }
    }
    
    func toggleOnSale() {
        onSale.toggle()
        if onSale {
            let productsOnSales = productsAux.filter { $0.onSale }
            presenter?.present(response: .data(response: productsOnSales))
        } else {
            presenter?.present(response: .data(response: productsAux))
        }
    }
}
