import Foundation

enum URLs {
    static let baseURL = "http://www.mocky.io/v2"
    
    static func to(path: String) -> URL? {
        return URL(string: "\(baseURL)\(path)")
    }
}
