import Foundation

// MARK: - Protocol
public protocol LoginServiceProtocol {
    
    func login(email: String, password: String) async throws -> LoginStatus
    func registerUser(name: String) async throws
}

// MARK: - Service
public class LoginService {
    
    private var defaultParameters: [String: String] {
        [
            "id": loginManager.userId
        ]
    }
    
    private let loginManager: LoginManager = FirebaseManager()
    
    public static let shared = LoginService()
    
    private init() {}
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
        
    public func registerUser(name: String) async throws {
        let data = User(name: name)
        
        do {
            let response: EmptyResponseAPI = try await URLSessionService
                .request(path: Constants.registerUserPath,
                         method: .post,
                         parameters: defaultParameters,
                         data: data)
            print("")
        } catch {
            print(error)
        }
    }
}

private extension LoginService {
    
    func createUser(email: String, password: String) async throws {
        try await loginManager.createUser(email: email, password: password)
    }
}
