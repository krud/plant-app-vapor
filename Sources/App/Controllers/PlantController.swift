import Fluent
import Vapor

struct PlantController {
    func index(req: Request) throws -> EventLoopFuture<[Plant]> {
        return Plant.query(on: req.db).all()
    }

    func create(req: Request) throws -> EventLoopFuture<Plant> {
        let plant = try req.content.decode(Plant.self)
        return plant.save(on: req.db).map { plant }
    }

//    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
//        return Plant.find(req.parameters.get("plantID"), on: req.db)
//            .unwrap(or: Abort(.notFound))
//            .flatMap { $0.delete(on: req.db) }
//            .transform(to: .ok)
//    }
}
