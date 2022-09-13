import Foundation

struct URLSessionService: RequestService {
    
    var parametersManager: ParametersManager
    
    var defaultParameters: [URLQueryItem] {
        [URLQueryItem(name: Constants.userIdParamKey, value: parametersManager.userId)]
    }
    
    init(parametersManager: ParametersManager) {
        self.parametersManager = parametersManager
    }
    
    func request<T: Decodable, D: Encodable>(
        path: String,
        method: URLMethod,
        parameters: [String: String]?,
        data body: D?
    ) async throws -> T {
        
        guard var components = URLComponents(string: Constants.baseURL) else { throw ErrorAPI.badURL }
        components.path = Constants.componentURL + path
        
        var queryItems: [URLQueryItem] = defaultParameters
        if let parameters = parameters {
            queryItems.append(contentsOf: parameters.map { URLQueryItem(name: $0, value: $1) })
        }
        
        components.queryItems = queryItems
        guard let url = components.url else { throw ErrorAPI.badURL }
        
        var request = URLRequest(url: url)
        request.addValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        if let body = body {
            guard let data = try? JSONEncoder().encode(body) else { throw ErrorAPI.badBody }
            
            request.httpBody = data
        }
        request.httpMethod = method.rawValue
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        debugPrint("--------------------")
        debugPrint(request)
        debugPrint(data.prettyPrintedJSONString)
        debugPrint("--------------------")
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw ErrorAPI.unknown }
        
        
        
        guard let decodedObj = try? JSONDecoder().decode(T.self, from: data) else { throw ErrorAPI.unknown }
        
        return decodedObj
    }
}

extension Data {
    var prettyPrintedJSONString: NSString { /// NSString gives us a nice sanitized debugDescription
            guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
                  let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted, .sortedKeys]),
                  let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return "" }

            return prettyPrintedString
        }
}
