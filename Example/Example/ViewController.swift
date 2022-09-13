import UIKit
import ConnectivityFramework

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        createRoomWith6Users()
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
    
    func createRoom() {
        Task {
            do {
                try await LoginService.shared.login(email: "jparias0731@gmail.com", password: "123456789")
                let room = try await RoomService.shared.createRoom()
                debugPrint("Created Room", room)
            } catch {
                debugPrint(error)
            }
        }
    }
    
    func joinRoom() {
        Task {
            do {
                try await LoginService.shared.login(email: "jparias0731@gmail.com", password: "123456789")
                try await RoomService.shared.joinRoom(id: "5989")
                debugPrint("Joined to Room", "5989")
            } catch {
                debugPrint(error)
            }
        }
    }
    
    func createRoomWith6Users() {
        Task {
            do {
                try await LoginService.shared.login(email: "jparias@gmail.com", password: "123456789")
                try await LoginService.shared.registerUser(name: "Jhonatan Pulgarin")
                let room = try await RoomService.shared.createRoom()
                
                RoomService.shared.bindToRoom(id: room.roomId) { room in
                    debugPrint("listeing to Room", room)
                }
                
                try await LoginService.shared.login(email: "didier@gmail.com", password: "123456789")
                try await LoginService.shared.registerUser(name: "didier")
                try await RoomService.shared.joinRoom(id: room.roomId)
                
                try await LoginService.shared.login(email: "maury@gmail.com", password: "123456789")
                try await LoginService.shared.registerUser(name: "maury")
                try await RoomService.shared.joinRoom(id: room.roomId)
                
                try await LoginService.shared.login(email: "sofan@gmail.com", password: "123456789")
                try await LoginService.shared.registerUser(name: "sofan")
                try await RoomService.shared.joinRoom(id: room.roomId)
                
                try await LoginService.shared.login(email: "laura@gmail.com", password: "123456789")
                try await LoginService.shared.registerUser(name: "laura")
                try await RoomService.shared.joinRoom(id: room.roomId)
                
                try await LoginService.shared.login(email: "cristian@gmail.com", password: "123456789")
                try await LoginService.shared.registerUser(name: "cristian")
                try await RoomService.shared.joinRoom(id: room.roomId)
                
                debugPrint("Joined to Room", room.roomId)
            } catch {
                debugPrint(error)
            }
        }
    }
    
    func fetchRoom() {
        Task {
            do {
                let room = try await RoomService.shared.fetchRoom(roomId: "3682")
                debugPrint("fetchRoom", room.roomId)
            } catch {
                debugPrint(error)
            }
        }
        
    }
}
