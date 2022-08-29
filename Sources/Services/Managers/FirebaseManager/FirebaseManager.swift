import Foundation
import FirebaseAuth

final class FirebaseManager { }

// MARK: - LoginManager
extension FirebaseManager: LoginManager {
    
    var isUserLogged: Bool {
        !userId.isEmpty
    }
    
    var userId: String {
        Auth.auth().currentUser?.uid ?? ""
    }
    
    func login(email: String, password: String) async throws {
        
        return try await withCheckedThrowingContinuation { continuation in
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                guard let error = error else{ return continuation.resume() }
                debugPrint("FirebaseManager.login error", error.localizedDescription)
                
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
                if let error = error {
                    debugPrint("FirebaseManager.createUser error", error.localizedDescription)
                    switch error._code {
                        
                    case 17026:
                        continuation.resume(throwing: ErrorAPI.weakPassword)
                                                
                    default:
                        continuation.resume(throwing: ErrorAPI.unknown)
                    }
                    return
                }
                guard result?.user.uid != nil else { return continuation.resume(throwing: ErrorAPI.unknown) }
                
                debugPrint("FirebaseManager.createUser ", email)

                continuation.resume(returning: ())
            }
        }
    }
    
    func signOut() async throws {
        try Auth.auth().signOut()
    }
}
