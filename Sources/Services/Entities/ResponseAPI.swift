import Foundation

typealias EmptyResponseAPI = ResponseAPI<EmptyData>

public struct ResponseAPI<D: Decodable>: Decodable {
    
    public let statusCode: Int
    public let data: D?
    
}

struct EmptyData: Decodable { }
