import UIKit
import ConnectivityFramework

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        trueEmail()
//        registerUser()
        weakPassword()
    }
    
    func trueEmail() {
        
        Task {
            do {
                let status = try await LoginService.shared.login(email: "maury@gmail.com", password: "electronica19")
                switch status {
                case .logged:
                    print("loguear")
                case .registerIsRequired:
                    try await LoginService.shared.registerUser(name: "Maury")
                }
            } catch {
                print(error)
            }
        }
    }
    
    func registerUser() {
        Task {
            do {
                try await LoginService.shared.registerUser(name: "Maury")
            } catch {
                print(error)
            }
        }
    }
    
    func weakPassword() {
        Task {
            do {
                let status = try await LoginService.shared.login(email: "maury@gmail.com", password: "123456789")
                switch status {
                case .logged:
                    print("loguear")
                case .registerIsRequired:
                    try await LoginService.shared.registerUser(name: "Maury")
                }
            } catch {
                print(error)
            }
        }
    }
}

