import UIKit
import ConnectivityFramework

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        trueEmail()
        registerUser()
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
}

