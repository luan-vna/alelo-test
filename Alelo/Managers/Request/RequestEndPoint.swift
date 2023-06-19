import Foundation

enum RequestEndPoint {
    case catalog
}

extension RequestEndPoint {
    
    func asURL() -> URL? {
        switch self {
        case .catalog:
            return URLs.to(path: "/59b6a65a0f0000e90471257d")
        }
    }
}
