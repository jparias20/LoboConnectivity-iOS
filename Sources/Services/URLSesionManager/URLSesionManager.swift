import Foundation

struct URLSessionService {
    
//    static func request<T: Decodable>(url: URL) async throws -> T {
//                
//        var request = URLRequest(url: url)
//        request.addValue(ConnectivityFrameworkConstant.token, forHTTPHeaderField: "Authorization")
//        request.addValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
//        
//        let (data, response) = try await URLSession.shared.data(for: request)
//        
//        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw ErrorAPI.responseError }
//        
//        guard let decodedObj = try? JSONDecoder().decode(T.self, from: data) else { throw ErrorAPI.noData }
//                            
//        return decodedObj
//    }
}
