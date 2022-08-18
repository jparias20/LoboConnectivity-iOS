import Foundation

struct URLSessionService {
    
    static func request<T: Decodable>(url: URL, method: Method = .get, body: Encodable? = nil) async throws -> T {
                
        var request = URLRequest(url: url)
        request.addValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        let json = ["name": ""]
        let dataBody: Data = NSKeyedArchiver.archivedData(withRootObject: json)
        request.httpBody = dataBody
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw ErrorAPI.unknown
            
        }
        
        guard let decodedObj = try? JSONDecoder().decode(T.self, from: data) else {
            throw ErrorAPI.unknown
        }
                            
        return decodedObj
    }
    enum Method: String {
        case get = "GET"
        case post = "POST"
    }
}
