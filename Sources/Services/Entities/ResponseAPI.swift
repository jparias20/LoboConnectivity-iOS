import Foundation

typealias EmptyResponseAPI = ResponseAPI<EmptyData>



public struct ResponseAPI<D: Decodable>: Decodable {
    
    public let statusCode: Int
    public let data: D?
    public let message: String?
}

struct EmptyData: Codable { }
