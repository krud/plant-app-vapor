import Fluent
import Vapor

struct UserController {
    func index(req: Request) throws -> EventLoopFuture<[User]> {
        return User.query(on: req.db).with(\.$plants).all()
    }
    
    func create(req: Request) throws -> EventLoopFuture<User> {
        try User.Create.validate(req)
        let create = try req.content.decode(User.Create.self)
        guard create.password == create.confirmPassword else {
            throw Abort(.badRequest, reason: "Passwords did not match")
        }
        let user = try User(
            name: create.name,
            username: create.username,
            email: create.email,
            passwordHash: Bcrypt.hash(create.password)
        )
        return user.save(on: req.db)
            .map { user }
    }
    
    func login(req: Request) throws -> EventLoopFuture<UserToken> {
        let user = try req.auth.require(User.self)
        let token = try user.generateToken()
        return token.save(on: req.db)
            .map { token }
    }
//    }
    
    
//    func profile(req: Request) throws -> EventLoopFuture<User> {
//        let token = try req.auth.require(User.self)
//        let user = try User.self
//        let userData =
//        return user.with(\.$plants).all()
//    }
    
    func logout(_ req: Request) throws -> HTTPResponseStatus {
        req.auth.logout(User.self)
        return HTTPResponseStatus(statusCode: 200)
    }
}
