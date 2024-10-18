import Foundation

class NetworkClient {
    func getItems(completion: @escaping (Result<[Item], Error>) -> Void) {
            let urlStr = "https://my-json-server.typicode.com/sumup-challenges/mobile-coding-challenge-data/items"
            let url = URL(string: urlStr)!
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    print("No data received")
                    return
                }
                guard let urlItems = try? JSONDecoder().decode([Item].self, from: data) else {
                    let decodingError = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to decode data"])
                    completion(.failure(decodingError))
                    return
                }
                completion(.success(urlItems))
            }
            
            task.resume()
        }
}
