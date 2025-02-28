import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }
    // Define a basic "status" route
    app.get("status") { req -> [String: Any] in
        return [
            "status": "Server is running",
            "error": false
        ]
    }
}
