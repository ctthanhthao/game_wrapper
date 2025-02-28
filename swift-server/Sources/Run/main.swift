import Vapor
import App  // Ensure you import the App module

struct Run {
    // The entry point for the application
    static func main() async throws {
        // Create and start the application asynchronously
        let app = try await Application.make()

        // Add your custom routes, middleware, etc.
        try await app.execute()
    }
}

// var app = Application()
// defer { app.shutdown() }

// Task {
//     do {
//         try await configure(app)  // ✅ Ensure `configure(app)` is correctly defined
//         try await app.execute()   // ✅ Use `execute()` instead of `run()`
//     } catch {
//         print("Failed to start app: \(error)")
//     }
// }
