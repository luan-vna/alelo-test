import UIKit

extension UIImageView {
    func load(url string: String?) {
        guard let string = string, let url = URL(string: string) else {
            return
        }
        self.fetchImage(url: url)
    }
    
    private func fetchImage(url: URL) {
        let cache = URLCache.shared
        let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 60.0)
        if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
            DispatchQueue.main.async {
                self.image = image
            }
        } else {
            URLSession.shared.dataTask(with: request, completionHandler: { [weak self] (data, response, error) in
                if let data = data, let response = response, let image = UIImage(data: data) {
                    let cachedData = CachedURLResponse(response: response, data: data)
                    cache.storeCachedResponse(cachedData, for: request)
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }).resume()
        }
    }
}
