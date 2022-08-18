import Foundation

//MARK: - LoginManager
protocol LoginManager {
    
    var userId: String { get set }
    
    func login(email: String, password: String) async throws
    func createUser(email: String, password: String) async throws
}

public enum LoginStatus {
    case logged
    case registerIsRequired
}

// MARK: - Protocol
public protocol LoginServiceProtocol {
    
    func login(email: String, password: String) async throws -> LoginStatus
    func createUser(email: String, password: String) async throws
    func registerUser(name: String) async throws
}

public class LoginService {
    private let loginManager: LoginManager
    
    public init() {
        self.loginManager = FirebaseManager()
    }
}

// MARK: - LoginServiceProtocol
extension LoginService: LoginServiceProtocol {
    
    public func login(email: String, password: String) async throws -> LoginStatus {
        do {
            try await loginManager.login(email: email, password: password)
            return LoginStatus.logged
        } catch {
            switch error {
            case ErrorAPI.userNotFound:
                try await createUser(email: email, password: password)
                return LoginStatus.registerIsRequired
            default:
                throw error as? ErrorAPI ?? ErrorAPI.unknown
                
            }
        }
    }
    
    public func createUser(email: String, password: String) async throws {
        try await loginManager.createUser(email: email, password: password)
    }
    
    public func registerUser(name: String) async throws {
        let path = String(format: Constants.registerUserPath, loginManager.userId)
        guard let url = URL(string: Constants.baseURL + path) else { throw ErrorAPI.unknown }
        
        do {
            let response: ResponseURLSession = try await URLSessionService.request(url: url)
            print("")
        } catch {
            print(error)
        }
    }
}
