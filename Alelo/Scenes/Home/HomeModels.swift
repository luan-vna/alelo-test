import UIKit

struct Catalog: Decodable {
    let products: [Product]
}

struct Product: Decodable {
    let name: String
    let style: String
    let onSale: Bool
    let regularPrice: String
    let actualPrice: String
    let image: String
    let sizes: [SizeProduct]
    
    struct SizeProduct: Decodable {
        let available: Bool
        let size: String
    }
}
