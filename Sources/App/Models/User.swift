import Fluent
import Vapor
import FluentPostgresDriver

final class User: Model, Content {
    static let schema = "users"
    
    @ID(key: "id")
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "username")
    var username: String
    
    @Field(key: "email")
    var email: String
    
    @Field(key: "password_hash")
    var passwordHash: String
    
    @Children(for: \.$user)
    var plants: [Plant]
    
    init(){ }
    
    init(id: UUID? = nil, name: String, username: String, email: String, passwordHash: String) {
        self.id = id
        self.name = name
        self.username = username
        self.email = email
        self.passwordHash = passwordHash
        
    }
}
extension User {
    struct Create: Content {
        var name: String
        var username: String
        var email: String
        var password: String
        var confirmPassword: String
    }
}

extension User.Create: Validatable {
    static func validations(_ validations: inout Validations) {
        validations.add("name", as: String.self, is: !.empty)
        validations.add("username", as: String.self, is: !.empty)
        validations.add("email", as: String.self, is: .email)
        validations.add("password", as: String.self, is: .count(8...))
    }
}

extension User: ModelUser {
    static let usernameKey = \User.$username
    static let passwordHashKey = \User.$passwordHash
    
    func verify(password: String) throws -> Bool {
        try Bcrypt.verify(password, created: self.passwordHash)
    }
}

extension User {
    func generateToken() throws -> UserToken {
        try .init(
            value: [UInt8].random(count: 16).base64,
            userID: self.requireID()
        )
    }
}

//extension User {
//    func removeToken() throws -> UserToken {
//
//    }
//}
