import Foundation

protocol CatalogManagerProtocol: AnyObject {
    
    func getAll() async -> Result<Catalog, Error>?
}

class CatalogManager: CatalogManagerProtocol {
    
    private var request: RequestManagerProtocol
    
    init(request: RequestManagerProtocol = RequestManager()) {
        self.request = request
    }
    
    func getAll() async -> Result<Catalog, Error>? {
        return await request.sendRequestAsGet(with: .catalog)
    }
}
