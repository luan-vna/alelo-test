import Foundation
@testable import Alelo

class CatalogManagerMock: CatalogManagerProtocol {
    
    private var request: RequestManagerProtocol
    
    init(request: RequestManagerProtocol = RequestManagerMock()) {
        self.request = request
    }
    
    func getAll() async -> Result<Catalog, Error>? {
        return await request.sendRequestAsGet(with: .catalog)
    }
}
