import Foundation

protocol LoginManager: ParametersManager {
    
    var isUserLogged: Bool { get }
    
    func login(email: String, password: String) async throws
    func createUser(email: String, password: String) async throws
    func signOut() async throws
}
