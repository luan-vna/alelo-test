import UIKit

class HomeWorker {
    
    private let request: CatalogManagerProtocol
    
    init(request: CatalogManagerProtocol = CatalogManager()) {
        self.request = request
    }
    
    func getAll() async -> Result<Catalog, Error>? {
        return await request.getAll()
    }
}
