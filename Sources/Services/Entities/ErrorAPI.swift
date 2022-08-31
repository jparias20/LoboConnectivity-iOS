import Foundation

public enum ErrorAPI: Error {
    case unknown
    case emailAlreadyInUse
    case invalidEmail
    case wrongPassword
    case userNotFound
    case badURL
    case badBody
    case weakPassword
    case noFound
    
    init(from statusCode: Int?) {
        switch statusCode {
        case 404:
            self = .noFound
            
        default:
            self = .unknown
        }
    }
}

