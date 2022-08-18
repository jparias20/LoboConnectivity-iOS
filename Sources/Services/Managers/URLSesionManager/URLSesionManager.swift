import Foundation

struct URLSessionService {
    
    static func request<T: Decodable, D: Encodable>(
        path: String,
        method: URLMethod = .get,
        parameters: [String: String]? = nil,
        data body: D? = nil
    ) async throws -> T {
        
        guard var components = URLComponents(string: Constants.baseURL) else { throw ErrorAPI.badURL }
        components.path = path

        if let parameters = parameters {
            components.queryItems = parameters.map { URLQueryItem(name: $0, value: $1) }
        }
        
        guard let url = components.url else { throw ErrorAPI.badURL }
        
        var request = URLRequest(url: url)
        request.addValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        if let body = body {
            guard let data = try? JSONEncoder().encode(body) else { throw ErrorAPI.badBody }
            
            request.httpBody = data
        }
        request.httpMethod = method.rawValue
        
        print(request)
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw ErrorAPI.unknown }
        
        guard let decodedObj = try? JSONDecoder().decode(T.self, from: data) else { throw ErrorAPI.unknown }
        
        return decodedObj
    }
    
}
