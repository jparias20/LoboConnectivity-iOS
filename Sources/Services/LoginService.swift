import Foundation

//MARK: - LoginManager
protocol LoginManager {
    
    func login(email: String, password: String) async throws
    func createUser (email: String, password: String) async throws -> String?
}

// MARK: - Protocol
public protocol LoginServiceProtocol {
    
    func login(email: String, password: String) async throws 
}

public class LoginService {
    private let loginManager: LoginManager
    
    public init() {
        self.loginManager = FirebaseManager()
    }
}

// MARK: - LoginServiceProtocol
extension LoginService: LoginServiceProtocol {
    
    public func login(email: String, password: String) async throws {
        try await loginManager.login(email: email, password: password)
    }
    public func createUser (email: String, password: String) async throws {
        Task {
            do {
                let id = try await loginManager.createUser(email: email, password: password)
                
            } catch {
                print("error")
            }
        }
    }
}
