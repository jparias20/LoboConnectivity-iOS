import Foundation

// MARK: - Protocol
public protocol LoginServiceProtocol {
    
    func login(email: String, password: String)
}

public class LoginService {
    
    public init() {
        print("From library")
    }
}

// MARK: - LoginServiceProtocol
extension LoginService: LoginServiceProtocol {
    
    public func login(email: String, password: String) {
        print("Login.....")
    }
}
