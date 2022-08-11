import Foundation
import FirebaseAuth

final class FirebaseManager {
    
    
}

// MARK: - LoginManager
extension FirebaseManager: LoginManager {
    
    func login(email: String, password: String) async throws {
        
        return try await withCheckedThrowingContinuation { continuation in
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                guard let error = error else{ return continuation.resume() }
                
                switch error._code {
                    
                case 17007:
                    continuation.resume(throwing: ErrorAPI.emailAlreadyInUse)
                    
                case 17008:
                    continuation.resume(throwing: ErrorAPI.invalidEmail)
                
                case 17009:
                    continuation.resume(throwing: ErrorAPI.wrongPassword)
                
                case 17011:
                    continuation.resume(throwing: ErrorAPI.userNotFound)
                    
                default:
                    continuation.resume(throwing: ErrorAPI.unknown)
                }
                
                    
            }
        }
    }
    func createUser (email: String, password: String) async throws -> String? {
        
        return try await withCheckedThrowingContinuation { continuation in
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                guard let _ = error else{ return continuation.resume(returning: result?.user.providerID) }
                continuation.resume(throwing: ErrorAPI.unknown)
            }
        }
    }
}
