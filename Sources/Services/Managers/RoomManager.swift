import Foundation
import Combine

protocol RoomManager: ParametersManager {
    
    func bindToRoom(roomId: String, completion: @escaping CompletionBlock)
}
