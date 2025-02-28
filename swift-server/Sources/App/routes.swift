import Vapor
import Foundation

actor GameState {
    private var isGameAllowed = false

    func setGameAllowed(_ allowed: Bool) {
        isGameAllowed = allowed
    }

    func getGameAllowed() -> Bool {
        return isGameAllowed
    }
}

let gameState = GameState()

func sendSMS(_ message: String) async {
    let accountSID = Environment.get("TWILIO_ACCOUNT_SID") ?? ""
    let authToken = Environment.get("TWILIO_AUTH_TOKEN") ?? ""
    let fromNumber = "+1 6292901074"
    let toNumber = Environment.get("MY_PHONE_NUMBER") ?? ""

    let url = URL(string: "https://api.twilio.com/2010-04-01/Accounts/\(accountSID)/Messages.json")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("Basic " + "\(accountSID):\(authToken)".data(using: .utf8)!.base64EncodedString(), forHTTPHeaderField: "Authorization")
    request.httpBody = "To=\(toNumber)&From=\(fromNumber)&Body=\(message)".data(using: .utf8)

    do {
        let (_, response) = try await URLSession.shared.data(for: request)
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 {
            print("SMS sent successfully")
        } else {
            print("Failed to send SMS")
        }
    } catch {
        print("Error sending SMS: \(error.localizedDescription)")
    }
}

func routes(_ app: Application) throws {
    app.get { req async -> String in
        """
        <html>
        <body style="text-align: center; font-family: Arial;">
            <h1>Game Request</h1>
            <p>Roblox is trying to start. Approve?</p>
            <a href="/allow"><button style="font-size: 20px;">Allow</button></a>
            <a href="/deny"><button style="font-size: 20px; background-color: red; color: white;">Deny</button></a>
        </body>
        </html>
        """
    }

    app.get("allow") { req async -> String in
        await gameState.setGameAllowed(true)
        return "Game Allowed"
    }

    app.get("deny") { req async -> String in
        await gameState.setGameAllowed(false)
        return "Game Denied"
    }

    app.get("status") { req async -> String in
        let status = await gameState.getGameAllowed()
        return status ? "allowed" : "denied"
    }

    // Send SMS when the game is detected
    app.get("notify") { req async -> String in
        let message = "Your child is opening Roblox. Approve?\n[ALLOW] https://yourserver.com/allow\n[DENY] https://yourserver.com/deny"
        await sendSMS(message)
        return "SMS Sent"
    }
}

