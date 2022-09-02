import UIKit
import ConnectivityFramework

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUserCompleteFlow()
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
        
    func fetchUserCompleteFlow() {
        Task {
            do {
                try await LoginService.shared.login(email: "test7@gmail.com", password: "123456789")
                
                try await LoginService.shared.registerUser(name: "test7")
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
