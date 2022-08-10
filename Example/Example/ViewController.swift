import UIKit
import ConnectivityFramework

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let service = LoginService()
        service.login(email: "algo", password: "12234")
    }


}

