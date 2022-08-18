import Foundation

enum ErrorAPI: Error {
    
    case unknown
    case emailAlreadyInUse
    case invalidEmail
    case wrongPassword
    case userNotFound
    case badURL
    case badBody
}

