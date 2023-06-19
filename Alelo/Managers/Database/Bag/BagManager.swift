import Foundation

protocol BagManagerProtocol {
    func exist(item: BagItem) -> Bool
    @discardableResult func add(item: BagItem) -> BagItem
    @discardableResult func remove(item: BagItem) -> BagItem?
    func all() -> [BagItem]
    func total() -> Double
}

class BagManager: BagManagerProtocol {
    
    static var shared = BagManager()
    
    private var database: Database?
    
    init(database: Database? = Database.shared) {
        self.database = database
    }
    
    func exist(item: BagItem) -> Bool {
        return database?.products.first(where: ({ $0 == item })) != nil
    }
    
    @discardableResult
    func add(item: BagItem) -> BagItem {
        let product = database?.products.first(where: ({ $0 == item }))
        var item = item
        if product != nil {
            item.quantity = item.quantity + (product?.quantity ?? 0)
            database?.products.removeAll(where: { $0 == item })
        }
        database?.products.append(item)
        return item
    }
    
    @discardableResult
    func remove(item: BagItem) -> BagItem? {
        guard let product = database?.products.first(where: ({ $0 == item })) else {
            return nil
        }
        var item = item
        let total = product.quantity - 1
        if total <= 0 {
            database?.products.removeAll(where: {$0 == item })
            return nil
        } else {
            item.quantity = total
            database?.products.removeAll(where: {$0 == item })
            database?.products.append(item)
        }
        return item
    }
    
    func all() -> [BagItem] {
        return database?.products ?? []
    }
    
    func total() -> Double {
        return all().map({ $0.total }).reduce(0, +)
    }
}
