import UIKit
import ConnectivityFramework

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUser()
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
    
    func fetchUserCompleteFlow() {
        Task {
            do {
                let status = try await LoginService.shared.login(email: "test6@gmail.com", password: "123456789")
                guard case .registerIsRequired = status else { return }
                
                try await LoginService.shared.registerUser(name: "test6")
                let user = try await LoginService.shared.fetchUser()
                debugPrint("Finished fetchUser", user)
                

            } catch {
                debugPrint(error)
            }
        }
    }
    
    func fetchUser() {
        Task {
            do {
                let user = try await LoginService.shared.fetchUser()
                debugPrint("Finished fetchUser", user)
                

            } catch {
                debugPrint(error)
            }
        }
    }
    
}
