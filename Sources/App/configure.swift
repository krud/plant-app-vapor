import Vapor
import Fluent
import FluentPostgresDriver
//import Leaf

public func configure(_ app: Application) throws {
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
//    app.views.use(.leaf)
//    if !app.environment.isRelease {
//        (app.leaf.cache as? DefaultLeafCache)?.isEnabled = false
//    }
    
    app.databases.use(.postgres(
        hostname: "localhost",
        username: "kelly",
        password: "nil",
        database: "plant"
    ), as: .psql)
    
    app.migrations.add(User.Migration())
    app.migrations.add(UserToken.Migration())
    app.migrations.add(CreatePlant())
    
    try routes(app)
}
