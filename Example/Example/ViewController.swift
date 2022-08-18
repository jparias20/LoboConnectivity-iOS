import UIKit
import ConnectivityFramework

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        failEmail()
//        trueEmailfailpassword()
        trueEmail()
    }
    
    func trueEmail() {
        
        let service = LoginService()
        Task {
            do {
                let status = try await service.login(email: "maury.mdin@gmail.com", password: "electronica19")
                switch status {
                case .logged:
                    print("loguear")
                case .registerIsRequired:
                    try await service.registerUser(name: "Maury")
                }
            } catch {
                print(error)
            }
        }
    }
    
    func failEmail() {
        let service = LoginService()
        Task {
            do {
                try await service.login(email: "algo", password: "algo")
            } catch {
                print(error)
            }
        }
    }
    
    func trueEmailfailpassword() {
        
        let service = LoginService()
        Task {
            do {
                try await service.login(email: "maury.mdin@gmail.com", password: "algo")
            } catch {
                print(error)
            }
        }
    }
}

