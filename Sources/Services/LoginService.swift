import Foundation

public typealias CompletionErrorBlock = (ErrorAPI) -> Void
public typealias CompletionSuccess<T: Decodable> = (T) -> Void
public typealias CompletionBlock = () -> Void

// MARK: - Protocol
public protocol LoginServiceProtocol {
    
    var isUserLogged: Bool { get }
    
    func login(email: String, password: String) async throws
    func registerUser(name: String) async throws
    func signOut() async throws
    func fetchUser() async throws -> User
}

// MARK: - Service
public class LoginService {
    
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
    
    public func login(email: String, password: String) async throws {
        do {
            try await loginManager.login(email: email, password: password)
        } catch {
            switch error {
            case ErrorAPI.userNotFound:
                try await createUser(email: email, password: password)
                
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
                    parameters: nil,
                    data: data
                )            
        } catch {
            throw error
        }
    }
    
    public func signOut() async throws {
        try await loginManager.signOut()
    }
    
    public func fetchUser() async throws -> User {
        let response: ResponseAPI<User> = try await requestService.request(
            path: Constants.userPath,
            method: .get,
            parameters: nil,
            data: nil as EmptyData?
        )
        
        guard let user = response.data else { throw ErrorAPI(from: response.statusCode) }
        
        return user
    }
}

private extension LoginService {
    
    func createUser(email: String, password: String) async throws {
        try await loginManager.createUser(email: email, password: password)
    }
}
