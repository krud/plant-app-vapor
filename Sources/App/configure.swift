import Vapor
import Fluent
import FluentPostgresDriver


// configures your application
public func configure(_ app: Application) throws {
    app.databases.use(.postgres(
        hostname: "localhost",
        username: "kelly",
        password: "nil",
        database: "plant"
    ), as: .psql)
    
//    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    app.migrations.add(User.Migration())
    app.migrations.add(UserToken.Migration())
    app.migrations.add(CreatePlant())
    // register routes
    
    try routes(app)
}
