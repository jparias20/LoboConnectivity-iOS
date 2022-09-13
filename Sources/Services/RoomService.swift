import Foundation
import Combine

public protocol RoomServiceProtocol {
    
    func createRoom() async throws -> Room
    func joinRoom(id: String) async throws
    func fetchRoom(roomId: String) async throws -> Room
    func bindToRoom(id: String, completion: @escaping CompletionSuccess<Room>)
}

public class RoomService {
    
    private let roomManager: RoomManager
    private let requestService: RequestService
    
    public static let shared = RoomService()
    
    private init() {
        roomManager = FirebaseManager()
        requestService = URLSessionService(parametersManager: roomManager)
    }
}

// MARK: - RoomServiceProtocol
extension RoomService: RoomServiceProtocol {
    
    public func createRoom() async throws -> Room {
        let response: ResponseAPI<Room> = try await requestService.request(
                path: Constants.createRoomPath,
                method: .post,
                parameters: nil,
                data: nil as EmptyData?
            )
        
        guard let data = response.data else { throw ErrorAPI(from: response.statusCode) }

        return data
    }
    
    public func joinRoom(id: String) async throws {
        let parameters = [Constants.roomIdParamKey: id]
        
        let _: EmptyResponseAPI = try await requestService.request(
                path: Constants.joinRoomPath,
                method: .post,
                parameters: parameters,
                data: nil as EmptyData?
            )
    }
    
    public func fetchRoom(roomId: String) async throws -> Room {
        let parameters = [Constants.roomIdParamKey: roomId]
        let response: ResponseAPI<Room> = try await requestService.request(
                path: Constants.fetchRoomPath,
                method: .get,
                parameters: parameters,
                data: nil as EmptyData?
            )
        
        guard let data = response.data else { throw ErrorAPI(from: response.statusCode) }

        return data
    }
    
    public func bindToRoom(id: String, completion: @escaping CompletionSuccess<Room>) {
        roomManager.bindToRoom(roomId: id) { [weak self] in
            guard let self = self else { return }
            Task {
                guard let room = try? await self.fetchRoom(roomId: id) else { return }
                completion(room)
            }
        }
    }
}
