import XCTest
@testable import Alelo

final class CatalogManagerTests: XCTestCase {

    func testLoadAllCatalog() async throws {
        let catalogManager = CatalogManagerMock(request: RequestManagerMock())
        let result = await catalogManager.getAll()
        switch result {
        case .success(let catalog):
            XCTAssertTrue(!catalog.products.isEmpty, "Produtos carregados com sucesso")
        default: break
        }
    }

    func testLoadAllCatalogWithOnSales() async throws {
        let catalogManager = CatalogManagerMock(request: RequestManagerMock())
        let result = await catalogManager.getAll()
        switch result {
        case .success(let catalog):
            let onsale = catalog.products.filter({ $0.onSale }).count
            XCTAssertTrue(onsale == 8, "Produtos em destaque carregados")
        default: break
        }
    }

    func testLoadAllCatalogWithNoOnSales() async throws {
        let catalogManager = CatalogManagerMock(request: RequestManagerMock())
        let result = await catalogManager.getAll()
        switch result {
        case .success(let catalog):
            let onsale = catalog.products.filter({ !$0.onSale }).count
            XCTAssertTrue(onsale == 14, "Produtos sem destaque carregados")
        default: break
        }
    }
}
