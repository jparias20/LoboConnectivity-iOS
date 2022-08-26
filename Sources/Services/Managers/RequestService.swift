import Foundation

protocol ParametersManager {
    
    var userId: String { get }
}

protocol RequestService {
    
    var parametersManager: ParametersManager { get }
    
    func request<T: Decodable, D: Encodable>(
        path: String,
        method: URLMethod,
        parameters: [String: String]?,
        data body: D?
    ) async throws -> T
}
