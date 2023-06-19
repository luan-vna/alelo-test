import Foundation

struct BagItem {
    
    let product: Product
    var addedAt: Date = Date()
    var quantity: Int = 1
    
    var total: Double {
        let actualPrice = product.actualPrice.toDouble()
        return actualPrice * Double(quantity)
    }
}

extension BagItem: Equatable {
    
    static func == (lhs: BagItem, rhs: BagItem) -> Bool {
        //Não vem ID na listagem de produtos, tive que fazer isso para identificar se um produto é o mesmo
        return "\(lhs.product.name)-\(lhs.product.style)" == "\(rhs.product.name)-\(rhs.product.style)"
    }
}
