import UIKit
import ConnectivityFramework

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let service = LoginService()
        Task {
            do {
                try await service.login(email: "maury.mdin@gmail.com", password: "electronica19")
                //try await service.createUser(email: "maury.mdin@gmail.com", password: "electronica19")
            } catch {
                print(error)
            }
        }
        
    }


}

