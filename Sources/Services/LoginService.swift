import Foundation
import FirebaseAuth

//MARK: - Enum for Login Type
enum ProviderType: String {
    case basic
    case google
    case facebook
}

// MARK: - Protocol
public protocol LoginServiceProtocol {
    
    func login(email: String, password: String, completionError: @escaping ((Error?) -> Void))
}

public class LoginService {
    
    //MARK: - Variables
    
    private(set) var email: String
    private(set) var provider: ProviderType
    
    init(email: String, provider: ProviderType) {
        self.email = email
        self.provider = provider
    }
    
}

// MARK: - LoginServiceProtocol
extension LoginService: LoginServiceProtocol {
    
    public func saveDataLogin() {
        
        let defaults = UserDefaults.standard
        defaults.set(email, forKey: "email")
        defaults.set(provider.rawValue, forKey: "provider")
        defaults.synchronize()
    }
    
    public func login(email: String, password: String, completionError: @escaping ((Error?) -> Void)) {
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error == nil {
                completionError(error)
            } else {
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    
                    completionError(error)
                }
            }
                
        }
    }
}
