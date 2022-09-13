import Foundation

struct Constants {
    static let baseURL = "https://lobo-api.netlify.app/netlify/functions/api"
    static let componentURL = "/.netlify/functions/api"
    
    static let registerUserPath = "/registerUser"
    static let userPath = "/user"
    static let createRoomPath = "/createRoom"
    static let joinRoomPath = "/joinTo"
    static let fetchRoomPath = "/room"
    
    static let userIdParamKey = "userId"
    static let roomIdParamKey = "roomId"
    
}
