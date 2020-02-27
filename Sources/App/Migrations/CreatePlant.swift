import Fluent

struct CreatePlant: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("plants")
            .field("id", .int, .identifier(auto: true))
            .field("name", .string)
            .field("common_name", .string)
            .field("latin_name", .string)
            .field("micro_env", .string)
            .field("alive", .bool)
            .field("user_id", .int, .references("users", "id"))
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("plants").delete()
    }
}
