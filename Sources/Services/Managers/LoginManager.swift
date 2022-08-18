import Foundation

protocol LoginManager {
    
    var userId: String { get }
    
    func login(email: String, password: String) async throws
    func createUser(email: String, password: String) async throws
}
