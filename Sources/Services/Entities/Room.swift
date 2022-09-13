import Foundation

public struct Room: Decodable {
    
    public let roomId: String
    public let isOpen: Bool
    public let ownerId: String
    public let players: [Player]
}
