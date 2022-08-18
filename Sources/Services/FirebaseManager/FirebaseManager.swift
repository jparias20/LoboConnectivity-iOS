import Foundation
import FirebaseAuth

final class FirebaseManager {
    
}

// MARK: - LoginManager
extension FirebaseManager: LoginManager {
    var userId: String {
        get {
            "123"
        }
        set {
            "123"
        }
    }
    
    
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
    
    func createUser(email: String, password: String) async throws {
        
        return try await withCheckedThrowingContinuation { continuation in
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                guard result?.user.uid != nil else { return continuation.resume(throwing: ErrorAPI.unknown) }
                self.userId = result?.user.uid ?? "123"
                continuation.resume(returning: ())
            }
        }
    }
}
