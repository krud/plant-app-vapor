import Vapor
import Fluent
// import Leaf

func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }
    app.get("test") { req in
        return "hitty hit!"
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
//    passwordProtected.post("profile", use: userController.profile)
    passwordProtected.post("logout", use: userController.logout)
    
    let tokenProtected = app.grouped(UserToken.authenticator().middleware())
    tokenProtected.get("profile") { req -> User in
        try req.auth.require(User.self)
    }

//    router.get("hello") { req -> Future<View> in
//        return try req.view().render("hello", ["name": "Leaf"])
//    }

    
}

