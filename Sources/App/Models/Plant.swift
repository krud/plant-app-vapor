import Fluent
import Vapor
import FluentPostgresDriver

final class Plant: Model, Content {
    static let schema = "plants"
    
    @ID(key: "id")
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "common_name")
    var commonName: String
    
    @Field(key: "latin_name")
    var latinName: String
    
    @Field(key: "micro_env")
    var microEnv: String
    
    @Field(key: "alive")
    var alive: Bool
    
    @Parent(key: "user_id")
    var user: User
    
    init() { }
    
    init(id: UUID? = nil, name: String, commonName: String, latinName: String, microEnv: String, alive: Bool, userID: UUID) {
        self.id = id
        self.name = name
        self.commonName = commonName
        self.latinName = latinName
        self.microEnv = microEnv
        self.alive = alive
        self.$user.id = userID
        
    }
}
