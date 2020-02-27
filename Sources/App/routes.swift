import Vapor
import Fluent

func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }
    
    app.get("users") { req in
        User.query(on: req.db).with(\.$plants).all()
    }
    
    let plantController = PlantController()
    app.get("plants", use: plantController.index)
    app.post("plants", use: plantController.create)
//    app.delete("plants", use: plantController.delete)

    let userController = UserController()
    app.post("users", use: userController.create)
//    app.post("users", use: userController.logout)
        
    let passwordProtected = app.grouped(User.authenticator().middleware())
    passwordProtected.post("login", use: userController.login)
    passwordProtected.post("logout", use: userController.logout)
    
    let tokenProtected = app.grouped(UserToken.authenticator().middleware())
    tokenProtected.get("me") { req -> User in
        try req.auth.require(User.self)
    }
    
}

