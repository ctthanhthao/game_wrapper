import Vapor

// configures your application
public func configure(_ app: Application) async throws {
    // Set the server to listen on port 8080
    app.http.server.configuration.port = 8080
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    // register routes
    try routes(app)
}
