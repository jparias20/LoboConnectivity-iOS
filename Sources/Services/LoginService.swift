import Foundation

// MARK: - Protocol
public protocol LoginServiceProtocol {
    
    var isUserLogged: Bool { get }
    
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
    
    private let loginManager: LoginManager
    private let requestService: RequestService
    
    public static let shared = LoginService()
    
    private init() {
        loginManager = FirebaseManager()
        requestService = URLSessionService(parametersManager: loginManager)
    }
}

// MARK: - LoginServiceProtocol
extension LoginService: LoginServiceProtocol {
    
    public var isUserLogged: Bool {
        loginManager.isUserLogged
    }
    
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
                throw error
            }
        }
    }
    
    public func registerUser(name: String) async throws {
        let data = User(name: name)
        
        do {
            let _: EmptyResponseAPI = try await requestService
                .request(
                    path: Constants.registerUserPath,
                    method: .post,
                    parameters: defaultParameters,
                    data: data
                )
            debugPrint("LoginService.registerUser", name)
            
        } catch {
            throw error
        }
    }
}

private extension LoginService {
    
    func createUser(email: String, password: String) async throws {
        try await loginManager.createUser(email: email, password: password)
    }
}
